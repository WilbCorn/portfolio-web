<script lang="ts">
    import type { Component } from 'svelte';

    // Inner Variables
    let commonStyleClass = "bg-[var(--primary-accent)] text-white font-bold items-center flex flex-row justify-center hover:cursor-pointer hover:bg-[var(--secondary-accent)]"

    let commonIconClass = "w-4 h-4 text-white"

    // Outer variables
    export let buttonText = "";
    export let icon: Component | null = null; 
    export let styleClass = buttonText 
        ? `${commonStyleClass} py-2 px-4 rounded`
        : `${commonStyleClass} p-2 rounded-xl`;
    export let iconClass = buttonText 
        ? `${commonIconClass} mr-2` 
        : `${commonIconClass}`;
    export let onclick = () => {};
</script>

<button class="{styleClass} transition-all duration-300 ease-in-out hover:scale-105" on:click={onclick}>
    {#if icon}
    <svelte:component this={icon} class="{iconClass}"/>
    {/if}
        {buttonText}
</button>