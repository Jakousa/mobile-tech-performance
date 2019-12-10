<script>
  import { onDestroy, createEventDispatcher } from "svelte";
  export let threshold = 0;
  const dispatch = createEventDispatcher();
  let component;
  $: {
    if (component) {
      component.parentNode.addEventListener("scroll", onScroll);
    }
  }

  const onScroll = e => {
    const offset =
      e.target.scrollHeight - e.target.clientHeight - e.target.scrollTop;
    if (offset <= threshold) {
      dispatch("loadMore");
    }
  };

  onDestroy(() => {
    component.parentNode.removeEventListener("scroll", null);
  });
</script>

<div bind:this={component} style="width:0px" />
