<script lang="ts">
    import type { Component } from 'svelte';

    export let icon: Component | null = null; 
    export let iconClass = "w-5 h-5 text-[var(--secondary-accent)]";
    export let attribute = "";
    export let value = "";

    export let commonTextClass = "text-2xl";
</script>

<div class="flex flex-col items-center justify-center space-y-2 border rounded-md p-3 w-[250px] h-[120px] min-h-[120px]">
    <div class="flex flex-row items-center justify-center space-x-2">
        {#if icon}
        <svelte:component this={icon} class="{iconClass}"/>
        {/if}
        <p class="{commonTextClass} font-bold text-[var(--secondary-accent)]">{attribute}</p>
    </div>
    <p class="{commonTextClass}">{value}</p>
</div>