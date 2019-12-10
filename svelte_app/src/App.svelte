<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";

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
  let prevDistance = 0;
  let prevSpeedTime = 0;
  let speed = 0;

  const speedRaportInterval = setInterval(() => {
    console.log(speed / rowHeight);
  }, 1000);

  const speedOMeter = setInterval(() => {
    const timeNow = new Date().getTime();
    const timeInInterval = (timeNow - prevSpeedTime) / 1000;
    speed = distanceTraveled / timeInInterval;
    prevSpeedTime = timeNow;
    distanceTraveled = 0;
  }, 100);

  let prevTop = 0;

  const sanicfunc = () => {
    sanic = false;
  }

  const handleScroll = e => {
    if (speed / rowHeight > 50) {
      if (sanic) clearTimeout(sanic);
      sanic = setTimeout(sanicfunc, 100);
    }
    const distanceFromTop = e.target.scrollTop;
    const progress = Math.abs(distanceFromTop - prevTop);
    prevTop = distanceFromTop;
    distanceTraveled += progress;

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
  <InfiniteScroll
    threshold={rowHeight * (bufferRowsBelow + 100)}
    on:loadMore={loadMore} />
</div>
