<script>
  import { onDestroy, createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  export let rowHeight;
  export let distanceTraveled;
  export let speed;
  let component;
  let prevDistance = 0;
  let prevSpeedTime = 0;
  let prevTop = 0;

  const speedRaportInterval = setInterval(() => {
    console.log(`Speed: ${speed / rowHeight}`);
  }, 1000);

  const speedOMeter = setInterval(() => {
    const timeNow = new Date().getTime();
    const timeInInterval = (timeNow - prevSpeedTime) / 1000;
    speed = distanceTraveled / timeInInterval;
    prevSpeedTime = timeNow;
    distanceTraveled = 0;
  }, 250);

  $: {
    if (component) {
      const element = component.parentNode;
      element.addEventListener("scroll", onScroll);
    }
  }

  const onScroll = e => {
    const distanceFromTop = e.target.scrollTop;
    const progress = Math.abs(distanceFromTop - prevTop);
    prevTop = distanceFromTop;
    distanceTraveled += progress;
  };

  onDestroy(() => {
    const element = elementScroll ? elementScroll : component.parentNode;
    element.removeEventListener("scroll", null);
  });
</script>

<div bind:this={component} style="width:0px" />
