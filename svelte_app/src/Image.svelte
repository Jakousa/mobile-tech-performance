<script>
  export let index;
  export let rowAt;
  export let highestShownRow;
  export let lowestShownRow;
  export let dimensions;
</script>

{#if rowAt >= highestShownRow}
  <img
    width={dimensions}
    height={dimensions}
    style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
    src={rowAt < highestShownRow || rowAt > lowestShownRow ? `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}` : `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}`}
    alt="" />
{/if}
