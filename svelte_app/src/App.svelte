<script>
  import SvelteInfiniteScroll from "svelte-infinite-scroll";

  const dimensions = 160;
	const rows = Math.ceil(window.screen.height / dimensions);
	const perRow = Math.floor(window.screen.width / dimensions);

	let items = Math.ceil(rows * perRow);
	console.log(items)
  $: items = items;
</script>

<style>
  div {
    width: 100vw;
    max-height: 100vh;
		overflow-x: scroll
	}
	img {
		float: left;
	}
</style>

<div>
  {#each { length: items } as _, i}
    <img
			width={dimensions}
			height={dimensions}
			style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`}
      src={`https://picsum.photos/${dimensions / 2}/${dimensions / 2}?cachekill=${Math.random()}`}
      alt="whops" />
  {/each}
  <SvelteInfiniteScroll
    threshold={perRow}
    on:loadMore={() => {
      items = items + (perRow * 10);
    }} />
</div>
