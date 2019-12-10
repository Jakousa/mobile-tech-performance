<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";
  import SpeedOMeter from "./SpeedOMeter.svelte";
  const dimensions = 84;
  const bufferRowsAbove = 0;
  const bufferRowsBelow = 5;
  const rowHeight = dimensions + 0;//4; // the image + padding
  const rowsOnScreen = 15+Math.ceil(window.screen.height / rowHeight); // How many rows are visible
  const itemsPerRow = 4; //Math.floor(window.screen.width / dimensions);
  const startTime = new Date().getTime();

  let speed = 0;
  let sanic = false;
  let items = Math.ceil(rowsOnScreen * itemsPerRow);
  let rowsAbove = 0;
  let rowsToBottom = window.innerHeight;

  let distanceFromTop = 0;

  let distanceTraveled = 0;

  const handleScroll = e => {
    distanceFromTop = e.target.scrollTop;
    const newRowsAbove = Math.floor(distanceFromTop / rowHeight);
    console.log(newRowsAbove, rowsAbove)
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    console.log("loadmore")
    items = items + itemsPerRow * (4 + Math.floor(speed / rowHeight));
  };

  $: console.log("??")
</script>

<div on:scroll={handleScroll}>
  <div
    style={`width: 100%; height: ${console.log(distanceFromTop)
    || 2*rowHeight+distanceFromTop-(distanceFromTop%rowHeight)-(rowHeight*bufferRowsAbove)}px;`}
  />
  {#each { length: items } as _, index}

      <!-- {#if index % itemsPerRow == 0 && index > 0}
        <br />
      {/if} -->

      {#if console.log(index, itemsPerRow, rowsAbove, bufferRowsAbove, (index + 0) / itemsPerRow, rowsAbove - (bufferRowsAbove)) || (index + 0) / itemsPerRow >= rowsAbove - (bufferRowsAbove)}
        <img
          width={dimensions}
          height={dimensions}
          style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
          src={
            (index + 0) / itemsPerRow < rowsAbove - (bufferRowsAbove / 2) || 
            (index + 0) / itemsPerRow > rowsToBottom + (bufferRowsBelow / 2 + Math.floor(speed / rowHeight)) ? 
            `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}` : `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}`}
          alt="" />
      {/if}
  {/each}
  <SpeedOMeter bind:speed {distanceTraveled} {rowHeight} />
  <!-- <InfiniteScroll
    threshold={rowHeight * (bufferRowsBelow + 20)}
    on:loadMore={loadMore} /> -->
</div>
