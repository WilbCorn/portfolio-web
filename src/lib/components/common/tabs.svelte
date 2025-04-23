<script lang="ts">

    interface TabItem {
      value: number;
      label: string;
      component: any;
    }
  
    export let items: TabItem[] = [];
    export let activeTabValue = 1;
  
    const handleClick = (tabValue: number) => () => (activeTabValue = tabValue);
</script>

<div class="flex flex-col items-center w-full">
  
  <!-- Tabs Navigation -->
  <div class="flex flex-wrap justify-center mb-8 sm:border sm:border-[var(--primary-accent)] sm:rounded-md">
    {#each items as item}
    
      <button
        type="button"
        class="{activeTabValue === item.value ? 
        'bg-[var(--primary-accent)] rounded-md hover:bg-[var(--secondary-accent)] text-white' : 
        'border border-[var(--primary-accent)] rounded-md text-[var(--primary-accent)] hover:text-[var(--secondary-accent)] sm:border-0'} 
        px-5 py-2 m-1 sm:m-0 cursor-pointer font-bold"
        on:click={handleClick(item.value)}
      >
        {item.label}
      </button>
    {/each}
  </div>
  
  
  <!-- Tab Content -->
  {#each items as item}
    {#if activeTabValue === item.value}
      <div class="p-1 rounded-md">
        <svelte:component this={item.component} />
      </div>
    {/if}
  {/each}

</div>