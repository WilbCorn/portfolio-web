<script lang="ts">
    import type { Component } from 'svelte';

    export let icon: Component | null = null; 
    export let iconClass = "w-7 h-7 text-[var(--secondary-accent)]";
    export let value = "";

    export let commonTextClass = "text-xl";
</script>

<div class="flex items-center gap-x-4 mx-auto xl:mx-0">
    {#if icon}
    <svelte:component this={icon} class="{iconClass}"/>
    {/if}
    <p class="{commonTextClass}">{value}</p>
</div>