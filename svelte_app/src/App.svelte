<script>
  import SvelteInfiniteScroll from "svelte-infinite-scroll";

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

  const handleScroll = e => {
    y = e.target.scrollTop;
    above = Math.floor(y / 84) - 10;
    bottom = Math.floor((y + window.innerHeight) / 84) + 10
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
    {#if ((i + 1) / perRow < above) || ((i + 1) / perRow) > bottom}
      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`}
        src={`https://avatars2.githubusercontent.com/u/468816?s=400&v=4`}
        alt="whops" />
    {:else}
      <img
        width={dimensions}
        height={dimensions}
        style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`}
        src={`https://mobvita.cs.helsinki.fi/id/${i}/${dimensions}`}
        alt="whops" />
    {/if}
    {#if i % 4 == 3}
      <br />
    {/if}
  {/each}
  <SvelteInfiniteScroll
    threshold={1000}
    on:loadMore={() => {
      items = items + perRow * 10;
    }} />
</div>
