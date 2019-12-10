<script>
  import { onDestroy, createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  export let rowHeight;
  export let distanceTraveled;
  export let sanic;
  let component;
  let prevDistance = 0;
  let prevSpeedTime = 0;
  let speed = 0;
  let prevTop = 0;

  const speedRaportInterval = setInterval(() => {
    console.log(speed / rowHeight);
  }, 1000);

  const speedOMeter = setInterval(() => {
    const timeNow = new Date().getTime();
    const timeInInterval = (timeNow - prevSpeedTime) / 1000;
    speed = distanceTraveled / timeInInterval;
    prevSpeedTime = timeNow;
    distanceTraveled = 0;
  }, 100);

  $: {
    if (component) {
      const element = component.parentNode;
      element.addEventListener("scroll", onScroll);
    }
  }

  const onScroll = e => {
    const distanceFromTop = e.target.scrollTop;
    if (speed / rowHeight > 50) {
      if (sanic) clearTimeout(sanic);
      sanic = setTimeout(() => {
        sanic = false;
      }, 100);
    }

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
