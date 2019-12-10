<script>
  import { onMount } from "svelte";
  import InfiniteScroll from "./InfiniteScroll.svelte";
  import SpeedOMeter from "./SpeedOMeter.svelte";
  import Image from "./Image.svelte";
  const dimensions = 84;
  const bufferRowsAbove = 0;
  const bufferRowsBelow = 5;
  const rowHeight = dimensions + 0; //4; // the image + padding
  const rowsOnScreen = 15 + Math.ceil(window.screen.height / rowHeight); // How many rows are visible
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
    rowsAbove = newRowsAbove;
    rowsToBottom = newRowsAbove + rowsOnScreen;
  };

  const loadMore = () => {
    items = items + itemsPerRow * (4 + Math.floor(speed / rowHeight));
  };

  onMount(() => {
    console.log("Ready");
  });
</script>

<div on:scroll={handleScroll} style={`padding-top: ${console.log(distanceFromTop)
      || 2*rowHeight+distanceFromTop-(distanceFromTop%rowHeight)-(rowHeight*bufferRowsAbove)}px;`} 
      >
  {#each { length: items } as _, index}
    <Image 
      {index}
      {itemsPerRow}
      {dimensions}
      rowAt={index / itemsPerRow}
      highestShownRow={rowsAbove - bufferRowsAbove}
      lowestShownRow={rowsToBottom + bufferRowsBelow}
    />
  {/each}
  <SpeedOMeter bind:speed {distanceTraveled} {rowHeight} />
  <InfiniteScroll
    threshold={rowHeight * (bufferRowsBelow + 20)}
    on:loadMore={loadMore} />
</div>
