<script>
  <img
    width={dimensions}
    height={dimensions}
    style={`min-height: ${dimensions}px; min-width: ${dimensions}px; background: #fafafa;`}
    src={
      (index + 0) / itemsPerRow < rowsAbove - (bufferRowsAbove / 2) || 
      (index + 0) / itemsPerRow > rowsToBottom + (bufferRowsBelow / 2 + Math.floor(speed / rowHeight)) ? 
      `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}` : `https://mobvita.cs.helsinki.fi/3/id/${index}/${dimensions}`}
    alt="" />
</script>