<script>
  import InfiniteScroll from "./InfiniteScroll.svelte";

  const dimensions = 84;
  const bufferRowsAbove = 10;
  const bufferRowsBelow = 5;
  const rowHeight = dimensions + 4; // the image + padding
  const rowsOnScreen = Math.ceil(window.screen.height / rowHeight); // How many rows are visible
  const itemsPerRow = 4; //Math.floor(window.screen.width / dimensions);

  let sanic = false;
  let items = Math.ceil(rowsOnScreen * itemsPerRow);
  let rowsAbove = 0;
  let rowsToBottom = window.innerHeight;

  let passedRows = 0;
  let startTime = new Date().getTime();
  const interval = setInterval(() => {
    console.log(sanic);
    const timeNow = new Date().getTime();
    const speed = passedRows / ((timeNow - startTime) / 1000);
    console.log(speed);
  }, 1000);

  var checkScrollSpeed = (function(settings) {
    settings = settings || {};

    var lastPos,
      newPos,
      timer,
      delta,
      delay = settings.delay || 50; // in "ms" (higher means lower fidelity )

    function clear() {
      lastPos = null;
      delta = 0;
    }

    clear();

    return function(e) {
      newPos = e.target.scrollTop;
      if (lastPos != null) {
        // && newPos < maxScroll
        delta = newPos - lastPos;
      }
      lastPos = newPos;
      clearTimeout(timer);
      timer = setTimeout(clear, delay);
      return delta;
    };
  })();

  const handleScroll = e => {
    const speed = Math.abs(checkScrollSpeed(e));
    if (speed > 330) {
      if (sanic) clearTimeout(sanic);
      sanic = setTimeout(() => {
        sanic = false;
      }, 100);
      if (sanic) console.log(speed);
    }
    const distanceFromTop = e.target.scrollTop;
    const newRowsAbove = Math.floor(distanceFromTop / dimensions + 4);
    if (newRowsAbove !== rowsAbove) passedRows++;
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    items = items + itemsPerRow * bufferRowsBelow;
  };
</script>

<div on:scroll={handleScroll} style={'padding-top: 4px'}>
  {#each { length: items } as _, index}
    {#if (index + 1) / itemsPerRow < rowsAbove - bufferRowsAbove || (index + 1) / itemsPerRow > rowsToBottom + bufferRowsBelow}
      {#if index % 4 == 3}
        <div
          style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`} />
      {/if}
    {:else}
      {#if index % 4 == 0 && index > 0}
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
    threshold={rowHeight * (bufferRowsBelow + 10)}
    on:loadMore={loadMore} />
</div>
