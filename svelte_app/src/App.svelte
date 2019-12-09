<script>
  import SvelteInfiniteScroll from "svelte-infinite-scroll";
  import VirtualList from "@sveltejs/svelte-virtual-list";

  const dimensions = 80;
  const rows = Math.ceil(window.screen.height / dimensions);
  const perRow = Math.floor(window.screen.width / dimensions);

  let items = Math.ceil(rows * perRow);
  let arr = [];
  for (let index = 0; index < items; index++) {
    arr.push(index);
  }
  const things = [
    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },
        { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },
        { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },
        { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },    { name: "one", number: 1 },
    { name: "two", number: 2 },
    { name: "three", number: 3 },
    { name: "six thousand and ninety-two", number: 6092 }
  ];
  /*
  { length: items, slice: (start, end) => {
      if (!start || !end) end = items;
      let arr = [];
      for (let index = start; index < end; index++) {
        arr.push(index);
      }
      console.log('Defining arr', arr, start, end);
      return arr;
    } }
  */
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

<VirtualList height="500px" items={arr} let:item>
  <p>{item}</p>
  {#each { length: items } as _, i}
    <img
      width={dimensions}
      height={dimensions}
      style={`min-height: ${dimensions}px; min-width: ${dimensions}px;`}
      src={`https://mobvita.cs.helsinki.fi/id/${i}/${dimensions}`}
      alt="whops" />
  {/each}
  <SvelteInfiniteScroll
    threshold={perRow}
    on:loadMore={() => {
      items = items + perRow * 10;
    }} />
</VirtualList>