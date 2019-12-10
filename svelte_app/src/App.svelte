<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";
  import SpeedOMeter from "./SpeedOMeter.svelte";
  const dimensions = 84;
  const bufferRowsAbove = 30;
  const bufferRowsBelow = 30;
  const rowHeight = dimensions + 4; // the image + padding
  const rowsOnScreen = Math.ceil(window.screen.height / rowHeight); // How many rows are visible
  const itemsPerRow = 4; //Math.floor(window.screen.width / dimensions);
  const startTime = new Date().getTime();

  let speed = 0;
  let sanic = false;
  let items = Math.ceil(rowsOnScreen * itemsPerRow);
  let rowsAbove = 0;
  let rowsToBottom = window.innerHeight;

  let distanceTraveled = 0;

  const handleScroll = e => {
    const newRowsAbove = Math.floor(e.target.scrollTop / rowHeight);
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    items = items + itemsPerRow * (4 + Math.floor(speed / rowHeight));
  };
</script>

<div on:scroll={handleScroll}>
  {#each { length: items } as _, index}

      {#if index % itemsPerRow == 0 && index > 0}
        <br />
      {/if}
      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
        src={
          (index + 1) / itemsPerRow < rowsAbove - (bufferRowsAbove / 2 + Math.floor(speed / rowHeight)) || 
          (index + 1) / itemsPerRow > rowsToBottom + (bufferRowsBelow / 2 + Math.floor(speed / rowHeight)) ? 
          '' : `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}`}
        alt="" />
  {/each}
  <SpeedOMeter bind:speed {distanceTraveled} {rowHeight} />
  <InfiniteScroll
    threshold={rowHeight * (bufferRowsBelow + 20)}
    on:loadMore={loadMore} />
</div>
