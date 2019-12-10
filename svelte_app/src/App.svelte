<script>
  import SvelteInfiniteScroll from "./InfiniteScroll.svelte";

  const dimensions = 80;
  const rows = Math.ceil(window.screen.height / dimensions);
  const perRow = 4; //Math.floor(window.screen.width / dimensions);

  const itemsInScreen = Math.ceil(rows * perRow);
  let items = itemsInScreen;
  let arr = [];
  for (let index = 0; index < items; index++) {
    arr.push(index);
  }
  let y = 0;
  let above = 0;
  let bottom = window.innerHeight;

  let passedRows = 0;
  let startTime = new Date().getTime();
  const interval = setInterval(() => {
    const timeNow = new Date().getTime();
    const speed = passedRows / ((timeNow - startTime) / 1000);
    console.log(speed);
  }, 1000);

  const handleScroll = e => {
    y = e.target.scrollTop;
    if (Math.floor(y / 84) !== above) passedRows++;
    above = Math.floor(y / 84);
    bottom = Math.floor((y + window.innerHeight) / 84);
  };
</script>

<style>
  div {
    width: 100vw;
    max-height: 100vh;
    overflow-x: scroll;
  }
  img {
    padding: 0 2px;
  }
</style>

<div on:scroll={handleScroll}>
  {#each { length: items } as _, i}
    {#if (i + 1) / perRow < above - 5 || (i + 1) / perRow > bottom + 5}
      {#if i % 4 == 3}
        <div
          style={`min-height: ${dimensions + 4}px; min-width: ${dimensions + 4}px;`} />
      {/if}
    {:else}
      {#if i % 4 == 0}
        <br />
      {/if}

      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`}
        src={`https://mobvita.cs.helsinki.fi/id/${i}/${dimensions}`}
        alt="whops" />
    {/if}
  {/each}
  <SvelteInfiniteScroll
    threshold={800}
    on:loadMore={() => {
      items = items + perRow * 15;
    }} />
</div>
