<script lang="ts">
  export let text: string;

  export let headingClass = 'text-4xl font-bold text-center text-center';

  export let divClass = 'flex flex-col items-center justify-center w-full pb-8';

</script>

<div class={divClass}>
<h1 class={headingClass}>{text}</h1>
</div>