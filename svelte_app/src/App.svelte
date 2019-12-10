<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";
  import SpeedOMeter from "./SpeedOMeter.svelte";
  const dimensions = 84;
  const bufferRowsAbove = 10;
  const bufferRowsBelow = 5;
  const rowHeight = dimensions + 4; // the image + padding
  const rowsOnScreen = Math.ceil(window.screen.height / rowHeight); // How many rows are visible
  const itemsPerRow = 4; //Math.floor(window.screen.width / dimensions);
  const startTime = new Date().getTime();

  let sanic = false;
  let items = Math.ceil(rowsOnScreen * itemsPerRow);
  let rowsAbove = 0;
  let rowsToBottom = window.innerHeight;

  let distanceTraveled = 0;

  const handleScroll = e => {
    const distanceFromTop = e.target.scrollTop;
    const newRowsAbove = Math.floor(distanceFromTop / dimensions + 4);
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    items = items + itemsPerRow * bufferRowsBelow * 33;
  };
</script>

<div on:scroll={handleScroll} style={'padding-top: 4px'}>
  {#each { length: items } as _, index}
    {#if (index + 1) / itemsPerRow < rowsAbove - bufferRowsAbove || (index + 1) / itemsPerRow > rowsToBottom + bufferRowsBelow}
      {#if index % itemsPerRow == itemsPerRow - 1}
        <div
          style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`} />
      {/if}
    {:else}
      {#if index % itemsPerRow == 0 && index > 0}
        <br />
      {/if}
      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
        src={sanic ? '' : `https://mobvita.cs.helsinki.fi/id/${index}/${dimensions}`}
        alt="" />
    {/if}
  {/each}
  <SpeedOMeter
    distanceTraveled={distanceTraveled}
    rowHeight={rowHeight}
    sanic={sanic} />
  <InfiniteScroll
    threshold={rowHeight * (bufferRowsBelow + 100)}
    on:loadMore={loadMore} />
</div>
