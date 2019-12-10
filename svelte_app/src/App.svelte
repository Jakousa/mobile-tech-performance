<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";

  const dimensions = 80;
  const bufferRowsAbove = 10;
  const bufferRowsBelow = 5;
  const rowHeight = dimensions + 4; // the image + padding
  const rowsOnScreen = Math.ceil(window.screen.height / rowHeight); // How many rows are visible
  const itemsPerRow = 4; //Math.floor(window.screen.width / dimensions);

  let items = Math.ceil(rowsOnScreen * itemsPerRow);
  let rowsAbove = 0;
  let rowsToBottom = window.innerHeight;

  let passedRows = 0;
  let startTime = new Date().getTime();
  const interval = setInterval(() => {
    const timeNow = new Date().getTime();
    const speed = passedRows / ((timeNow - startTime) / 1000);
    console.log(speed);
  }, 1000);

  const handleScroll = e => {
    const distanceFromTop = e.target.scrollTop;
    const newRowsAbove = Math.floor(distanceFromTop / 84);
    if (newRowsAbove !== rowsAbove) passedRows++;
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    items = items + itemsPerRow * bufferRowsBelow;
  };
</script>

<div on:scroll={handleScroll}>
  {#each { length: items } as _, index}
    {#if (index + 1) / itemsPerRow < rowsAbove - bufferRowsAbove || (index + 1) / itemsPerRow > rowsToBottom + bufferRowsBelow}
      {#if index % 4 == 3}
        <div
          style={`min-height: ${dimensions + 4}px; min-width: ${dimensions + 4}px;`} />
      {/if}
    {:else}
      {#if index % 4 == 0 && index > 0}
        <br />
      {/if}
      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
        src={`https://mobvita.cs.helsinki.fi/id/${index}/${dimensions}`}
        alt="whops" />
    {/if}
  {/each}
  <InfiniteScroll threshold={rowHeight * (bufferRowsBelow + 10)} on:loadMore={loadMore} />
</div>
