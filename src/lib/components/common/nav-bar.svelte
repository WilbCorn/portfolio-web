<script lang="ts">
  import { m } from '$lib/paraglide/messages.js';
  import { setLocale } from '$lib/paraglide/runtime';
  import type { Locale } from '$lib/paraglide/runtime';
  import { MoonStar, Sun } from '@lucide/svelte';
  import { page } from '$app/state';
  import { ModeWatcher, toggleMode, userPrefersMode } from 'mode-watcher';
  import { writable } from 'svelte/store';

  import '$lib/styles/global.css'
	import { onMount } from 'svelte';

  type Language = {
    code: Locale;
    label: String;
  }

  // Available languages
  const languages : Language[] = [
    { code: 'en', label: 'English' },
    { code: 'ms', label: 'Malay' },
    { code: 'zh-cn', label: '中文' }
  ] as const;

  // Navigation items
  const navItems = [
    { href: '/', label: m.nav_home },
    { href: '/projects', label: m.nav_projects },
    { href: '/contact', label: m.nav_contact }
  ] as const;

  // Get currently selected language
  let currentLanguage : Locale;

    // Initialize language on mount
  onMount(() => {
    currentLanguage = localStorage.getItem('preferred-lang') as Locale;
    setLocale(currentLanguage);
  });

  function handleLanguageChange(e: Event) {
    const newLang = (e.target as HTMLSelectElement).value as Locale;
    localStorage.setItem('preferred-lang', newLang);
    currentLanguage = newLang;
    setLocale(currentLanguage);
  }

  // Initialize theme state
  export const isDarkMode = writable(false);

  // Subscribe to user preference changes
  userPrefersMode.subscribe((mode) => {
    isDarkMode.set(mode === 'dark');
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
    {#each navItems as { href, label }}
      <li class="relative">
        <a {href} class="hover:text-primary">{label()}</a>
        {#if page.url.pathname === href}
          <span class="absolute bottom-[-4px] left-0 w-full h-[2px] rounded-4xl selected-span"></span>
        {/if}
      </li>
    {/each}
  </ul>

  <!-- Language Selector -->
  <div class="flex items-center space-x-4">
    <select 
      class="bg-transparent border rounded px-2 py-1 appearance-none cursor-pointer pr-8"
      on:change={handleLanguageChange}
      bind:value={currentLanguage}
    >
      {#each languages as lang}
        <option value={lang.code}>{lang.label}</option>
      {/each}
    </select>

  <!-- Theme Toggle Button -->
  <button
    class="hover:text-primary"
    on:click={toggleMode}
    aria-label={isDarkMode ? 'Switch to light mode' : 'Switch to dark mode'}
  >
    {#if isDarkMode}
      <MoonStar class="w-8 h-8 p-1.5 text-black rounded-full bg-gray-200" />
    {:else}
      <Sun class="w-8 h-8 p-1.5 text-yellow-400 rounded-full bg-gray-700" />
    {/if}
  </button>
</div>
</nav>