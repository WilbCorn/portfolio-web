<script lang="ts">
	import { m } from '$lib/paraglide/messages.js';
	import { setLocale } from '$lib/paraglide/runtime';
	import type { Locale } from '$lib/paraglide/runtime';
	import { MoonStar, Sun, Menu, X } from '@lucide/svelte';
	import { page } from '$app/state';
	import { ModeWatcher, toggleMode, userPrefersMode } from 'mode-watcher';
	import { writable } from 'svelte/store';

	import '$lib/styles/global.css';
	import { onMount } from 'svelte';
	import ButtonIcon from './button-icon.svelte';

	type Language = {
		code: Locale;
		label: String;
	};

	// Available languages
	const languages: Language[] = [
		{ code: 'en', label: 'English' },
		{ code: 'ms', label: 'Malay' },
		{ code: 'zh-cn', label: '中文' },
		{ code: 'id', label: 'Indonesian' },
	] as const;

	// Navigation items
	const navItems = [
		{ href: '/', label: m.nav_home },
		{ href: '/projects', label: m.nav_projects },
		{ href: '/contact', label: m.nav_contact }
	] as const;

	// Get currently selected language
	let currentLanguage: Locale;

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
	export const isDarkMode = writable();

	// Subscribe to user preference changes
	userPrefersMode.subscribe((mode) => {
		isDarkMode.set(mode === 'dark');
	});

	// Add mobile menu state
	let isMobileMenuOpen = false;
	const toggleMobileMenu = () => {
		isMobileMenuOpen = !isMobileMenuOpen;
	};
</script>

<ModeWatcher lightClassNames={['light']} darkClassNames={['dark']} />

<nav class="flex items-center justify-between px-4 py-6 sm:p-2 lg:p-4 relative">
	<!-- Logo -->
	<div class="flex items-center space-x-4">
		<span class="text-primary text-xl font-bold">WTCS</span>
	</div>

	<!-- Hamburger Menu Button (visible on mobile) -->
	<button 
		class="sm:hidden z-30"
		on:click={toggleMobileMenu}
		aria-label="Toggle menu"
	>
		{#if isMobileMenuOpen}
			<X class="w-6 h-6 text-[var(--fg)]" />
		{:else}
			<Menu class="w-6 h-6 text-[var(--fg)]" />
		{/if}
	</button>

	<!-- Mobile Menu Overlay -->
	{#if isMobileMenuOpen}
		<div class="fixed inset-0 bg-[var(--bg)] z-20 sm:hidden">
			<div class="flex flex-col items-center pt-20 space-y-8">
				<!-- Navigation Links -->
				<ul class="flex flex-col items-center space-y-6">
					{#each navItems as { href, label }}
						<li class="relative">
							<a 
								{href} 
								class="hover:text-primary font-bold text-lg"
								on:click={toggleMobileMenu}
							>
								{label()}
							</a>
							{#if page.url.pathname === href}
								<span class="selected-span absolute bottom-[-4px] left-0 h-[2px] w-full rounded-4xl"></span>
							{/if}
						</li>
					{/each}
				</ul>

				<!-- Language Selector -->
				<select
					class="cursor-pointer appearance-none rounded border bg-transparent px-2 py-1 pr-8 text-[var(--primary-accent)]"
					on:change={handleLanguageChange}
					bind:value={currentLanguage}
				>
					{#each languages as lang}
						<option value={lang.code}>{lang.label}</option>
					{/each}
				</select>

				<!-- Theme Toggle -->
				<ButtonIcon onclick={toggleMode} icon={$isDarkMode ? MoonStar : Sun} />
			</div>
		</div>
	{/if}

	<!-- Desktop Navigation (hidden on mobile) -->
	<div class="hidden sm:flex items-center space-x-8">
		<!-- Navigation Links -->
		<ul class="flex space-x-8 z-20">
			{#each navItems as { href, label }}
				<li class="relative">
					<a {href} class="hover:text-primary font-bold">{label()}</a>
					{#if page.url.pathname === href}
						<span class="selected-span absolute bottom-[-4px] left-0 h-[2px] w-full rounded-4xl"></span>
					{/if}
				</li>
			{/each}
		</ul>

		<!-- Language Selector and Theme Toggle -->
		<div class="flex items-center space-x-4">
			<select
				class="cursor-pointer appearance-none rounded border bg-transparent px-2 py-1 pr-8 text-[var(--primary-accent)]"
				on:change={handleLanguageChange}
				bind:value={currentLanguage}
			>
				{#each languages as lang}
					<option value={lang.code}>{lang.label}</option>
				{/each}
			</select>

			<ButtonIcon onclick={toggleMode} icon={$isDarkMode ? MoonStar : Sun} />
		</div>
	</div>
</nav>
