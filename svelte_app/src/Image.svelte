<script>
  export let index;
  export let rowAt;
  export let highestShownRow;
  export let lowestShownRow;
  export let dimensions;

  export let srcThreshold;
  export let imgThreshold;
</script>

{#if highestShownRow - imgThreshold < rowAt && rowAt < lowestShownRow + imgThreshold}
  <img
    width={dimensions}
    height={dimensions}
    style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
    src={highestShownRow - srcThreshold < rowAt && rowAt < lowestShownRow + srcThreshold ? `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}` : ''}
    alt="" />
{/if}
