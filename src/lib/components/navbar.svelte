<script>
  import { m } from '$lib/paraglide/messages.js';
  import { MoonStar, Sun } from '@lucide/svelte';

  import '$lib/styles/global.css'
	import { ModeWatcher, toggleMode, userPrefersMode } from 'mode-watcher';

  // Initialize theme state
  let isDarkMode = false;

  // Subscribe to user preference changes
  userPrefersMode.subscribe((mode) => {
    isDarkMode = mode === 'dark'; // Update the state reactively
  });
</script>

<ModeWatcher lightClassNames={['light']} darkClassNames={['dark']} />

<nav class="px-4 py-6 flex justify-between items-center sm:p-2 lg:p-4">
  <!-- Logo -->
  <div class="flex items-center space-x-4">
    <span class="text-xl font-bold text-primary">WTCS</span>
  </div>

  <!-- Navigation Links -->
  <ul class="flex space-x-8">
    <li><a href="/" class="hover:text-primary">{m.nav_home()}</a></li>
    <li><a href="/" class="hover:text-primary">{m.nav_projects()}</a></li>
    <li><a href="/" class="hover:text-primary">{m.nav_contact()}</a></li>
  </ul>


  <!-- Theme Toggle Button -->
  <button
    class="hover:text-primary"
    onclick={toggleMode}
  >
    {#if isDarkMode}
      <MoonStar class="w-8 h-8 p-1.5 text-black rounded-full  bg-gray-200" />
    {:else}
      <Sun class="w-8 h-8 p-1.5 text-yellow-400  rounded-full  bg-gray-700" />
    {/if}
  </button>
</nav>