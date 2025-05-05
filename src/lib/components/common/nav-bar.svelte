<script lang="ts">
	import { Moon, Sun, Menu, X, ChevronDown } from '@lucide/svelte';
	import { ModeWatcher, toggleMode, userPrefersMode } from 'mode-watcher';
	import { writable } from 'svelte/store';
	import { fade, slide } from 'svelte/transition';

	import '$lib/styles/global.css';
	import { onMount } from 'svelte';
	import ButtonIcon from './button-icon.svelte';

	// Navigation items with subitems for About Me
	const navItems = [
		{ href: '#home', label: 'Home' },
		{
			href: '#about',
			label: 'About',
			subitems: [
				{ href: '#about-skills', label: 'Skills' },
				{ href: '#about-experiences', label: 'Experience' },
				{ href: '#about-careers', label: 'Careers' },
				{ href: '#about-qualifications', label: 'Qualifications' }
			]
		},
		{ href: '#projects', label: 'Projects' },
		{ href: '#contact', label: 'Contact' }
	] as const;

	// Track if a dropdown is open
	let openDropdown = '';

	function toggleDropdown(href: string) {
		if (openDropdown === href) {
			openDropdown = '';
		} else {
			openDropdown = href;
		}
	}

	// Initialize theme state
	export const isDarkMode = writable();

	// Subscribe to user preference changes
	userPrefersMode.subscribe((mode) => {
		isDarkMode.set(mode === 'dark');
	});

	let isMobileMenuOpen = false;
	const toggleMobileMenu = () => {
		isMobileMenuOpen = !isMobileMenuOpen;
	};

	let activeSection = '';
	$: isAboutActive = activeSection === '#about' || activeSection.startsWith('#about-');

	let showThemeButton = false;

	onMount(() => {
		// Set up intersection observer to detect active section with lower threshold
		const observer = new IntersectionObserver(
			(entries) => {
				entries.forEach((entry) => {
					if (entry.isIntersecting) {
						activeSection = '#' + entry.target.id;
					}
				});
			},
			{ threshold: 0.2 }
		);

		setTimeout(() => {
			// Observe all sections
			const sections = document.querySelectorAll(
				'#home, #about, #about-skills, #about-experiences, #about-careers, #about-qualifications, #projects, #contact'
			);

			sections.forEach((section) => {
				observer.observe(section);
			});
		}, 500);

		setTimeout(() => {
			// Additional delay for theme button
			setTimeout(() => {
				showThemeButton = true;
			}, 50);
		}, 50);
	});

	// Scroll handler function
	function handleNavClick(e: Event, href: string) {
		e.preventDefault();
		const element = document.querySelector(href);
		if (element) {
			element.scrollIntoView({ behavior: 'smooth' });
		}
		// Close mobile menu if open
		if (isMobileMenuOpen) {
			toggleMobileMenu();
		}
	}

	// Track if any mobile submenus are open
	let openMobileSubmenu = '';

	function toggleMobileSubmenu(href: string) {
		if (openMobileSubmenu === href) {
			openMobileSubmenu = '';
		} else {
			openMobileSubmenu = href;
		}
	}
</script>

<ModeWatcher lightClassNames={['light']} darkClassNames={['dark']} />

<nav
	class="fixed top-0 right-0 left-0 z-50 flex items-center justify-between bg-[var(--bg)] px-4 py-6 transition-all duration-300 ease-in-out sm:p-2 md:p-3"
>
	<!-- Logo -->
	<div class="flex items-center space-x-4 pl-3">
		<span class="text-primary text-xl font-bold">WTCS</span>
	</div>

	<!-- Hamburger Menu Button (visible on mobile) -->
	<button class="z-30 sm:hidden" on:click={toggleMobileMenu} aria-label="Toggle menu">
		{#if isMobileMenuOpen}
			<X class="h-6 w-6 text-[var(--fg)]" />
		{:else}
			<Menu class="h-6 w-6 text-[var(--fg)]" />
		{/if}
	</button>

	<!-- Mobile Menu Overlay -->
	{#if isMobileMenuOpen}
		<div class="fixed inset-0 z-20 overflow-y-auto bg-[var(--bg)] sm:hidden">
			<div class="flex flex-col items-center space-y-6 px-4 pt-16 pb-8">
				<!-- Navigation Links -->
				<ul class="flex w-full flex-col items-center space-y-6">
					{#each navItems as item, i}
						<li
							class="group relative w-full text-center"
							in:fade={{ duration: 200, delay: i * 100 }}
						>
							{#if 'subitems' in item}
								<!-- Parent item with dropdown -->
								<button
									class="relative flex w-full items-center justify-center gap-2 px-2 py-1.5 text-lg font-bold
										  {item.href === '#about' && isAboutActive
										? 'text-[var(--primary-accent)]'
										: activeSection.startsWith(item.href)
											? 'text-[var(--primary-accent)]'
											: 'hover:text-[var(--secondary-accent)]'}
										  transform-gpu transition-all duration-300
										  ease-in-out hover:scale-105"
									on:click={() => toggleMobileSubmenu(item.href)}
								>
									{item.label}
									<ChevronDown
										class="h-4 w-4 transition-transform duration-300 
											 {openMobileSubmenu === item.href ? 'rotate-180' : ''}"
									/>
								</button>

								{#if openMobileSubmenu === item.href}
									<div
										class="mt-2 w-full rounded-lg bg-[var(--bg-secondary)]/30 py-2"
										transition:slide={{ duration: 200 }}
									>
										{#each item.subitems as subitem, j}
											<a
												href={subitem.href}
												on:click={(e) => handleNavClick(e, subitem.href)}
												class="block px-4 py-2.5 text-base
													  {activeSection === subitem.href ? 'font-medium text-[var(--primary-accent)]' : 'text-[var(--fg)]'}
													  transition-colors hover:bg-[var(--fg)]/5"
												in:fade={{ delay: j * 50, duration: 150 }}
											>
												{subitem.label}
											</a>
										{/each}
									</div>
								{/if}
							{:else}
								<!-- Regular item -->
								<a
									href={item.href}
									on:click={(e) => handleNavClick(e, item.href)}
									class="relative block px-2 py-1.5 text-lg font-bold
										  {activeSection === item.href
										? 'text-[var(--primary-accent)]'
										: 'hover:text-[var(--secondary-accent)]'}
										  transform-gpu transition-all duration-300
										  ease-in-out hover:scale-105"
								>
									{item.label}
								</a>
							{/if}
						</li>
					{/each}
				</ul>

				<!-- Theme Toggle -->
				<div class="flex items-center space-x-4 duration-300 ease-in-out">
					<div class="relative flex h-10 w-10 items-center justify-center">
						<!-- Placeholder circle that's visible until the real button loads -->
						<div class="h-8 w-8 rounded-full bg-[var(--fg)]/5 opacity-30"></div>

						<div
							class="theme-button absolute inset-0 flex items-center justify-center {showThemeButton
								? 'visible'
								: ''}"
						>
							{#if $isDarkMode}
								<div class="absolute inset-0 flex items-center justify-center">
									<ButtonIcon onclick={toggleMode} icon={Moon} />
								</div>
							{:else}
								<div class="absolute inset-0 flex items-center justify-center">
									<ButtonIcon onclick={toggleMode} icon={Sun} />
								</div>
							{/if}
						</div>
					</div>
				</div>
			</div>
		</div>
	{/if}

	<!-- Desktop Navigation (hidden on mobile) -->
	<div class="hidden items-center space-x-8 sm:flex">
		<!-- Navigation Links -->
		<ul class="z-20 flex items-center space-x-8">
			{#each navItems as item}
				<li class="group relative">
					{#if 'subitems' in item && item.href === '#about'}
						<!-- About item with dropdown -->
						<button
							on:click={() => toggleDropdown(item.href)}
							class="relative flex items-center gap-1 py-1 font-bold
						  {isAboutActive ? 'text-[var(--primary-accent)]' : 'hover:text-[var(--secondary-accent)]'}
						  transition-colors duration-300 ease-in-out"
						>
							{item.label}
							<ChevronDown
								class="h-4 w-4 transition-transform duration-300 
								 {openDropdown === item.href ? 'rotate-180' : ''}"
							/>
						</button>

						<!-- Hover underline for About -->
						<span
							class="absolute bottom-0 left-0 h-0.5 w-0 bg-[var(--secondary-accent)]
								   transition-all duration-300 ease-out group-hover:w-full
								   {isAboutActive ? 'opacity-0' : 'opacity-100'}"
						></span>

						<!-- Active underline for About -->
						{#if isAboutActive}
							<span
								class="absolute bottom-0 left-0 h-0.5 w-full
									   bg-[var(--primary-accent)]"
								in:slide={{ duration: 300, axis: 'x' }}
							></span>
						{/if}

						<!-- Dropdown menu -->
						{#if openDropdown === item.href}
							<div
								class="absolute top-full left-0 z-30 mt-2 min-w-[150px] rounded-md
									   border border-[var(--fg)]/10 bg-[var(--bg)] py-2 shadow-lg"
								transition:fade={{ duration: 200 }}
							>
								{#each item.subitems as subitem, i}
									<a
										href={subitem.href}
										on:click={(e) => handleNavClick(e, subitem.href)}
										class="block px-4 py-2 text-sm hover:bg-[var(--fg)]/10
											   {activeSection === subitem.href ? 'text-[var(--primary-accent)]' : 'text-[var(--fg)]'}"
										in:fade={{ delay: i * 50, duration: 150 }}
									>
										{subitem.label}
									</a>
								{/each}
							</div>
						{/if}
					{:else if 'subitems' in item}
						<!-- Other items with subitems -->
						<button
							on:click={() => toggleDropdown(item.href)}
							class="relative flex items-center gap-1 py-1 font-bold
						  {activeSection === item.href || activeSection.startsWith(item.href + '-')
								? 'text-[var(--primary-accent)]'
								: 'hover:text-[var(--secondary-accent)]'}
						  transition-colors duration-300 ease-in-out"
						>
							{item.label}
							<ChevronDown
								class="h-4 w-4 transition-transform duration-300 
								 {openDropdown === item.href ? 'rotate-180' : ''}"
							/>
						</button>

						<!-- Dropdown menu -->
						{#if openDropdown === item.href}
							<div
								class="absolute top-full left-0 z-30 mt-2 min-w-[150px] rounded-md
									   border border-[var(--fg)]/10 bg-[var(--bg)] py-2 shadow-lg"
								transition:fade={{ duration: 200 }}
							>
								{#if item.subitems && Array.isArray(item.subitems)}
									{#each item.subitems as subitem, i}
										<a
											href={subitem.href}
											on:click={(e) => handleNavClick(e, subitem.href)}
											class="block px-4 py-2 text-sm hover:bg-[var(--fg)]/10
											   {activeSection === subitem.href ? 'text-[var(--primary-accent)]' : 'text-[var(--fg)]'}"
											in:fade={{ delay: i * 50, duration: 150 }}
										>
											{subitem.label}
										</a>
									{/each}
								{/if}
							</div>
						{/if}
					{:else}
						<!-- Regular menu item -->
						<a
							href={item.href}
							on:click={(e) => handleNavClick(e, item.href)}
							class="relative py-1 font-bold
								  {activeSection === item.href
								? 'text-[var(--primary-accent)]'
								: 'hover:text-[var(--secondary-accent)]'}
								  transition-colors duration-300 ease-in-out"
						>
							{item.label}
							<!-- Hover underline -->
							<span
								class="absolute bottom-0 left-0 h-0.5 w-0 bg-[var(--secondary-accent)]
									   transition-all duration-300 ease-out group-hover:w-full
									   {activeSection === item.href ? 'opacity-0' : 'opacity-100'}"
							>
							</span>
							<!-- Active underline -->
							{#if activeSection === item.href}
								<span
									class="absolute bottom-0 left-0 h-0.5 w-full
										   bg-[var(--primary-accent)]"
									in:slide={{ duration: 300, axis: 'x' }}
								></span>
							{/if}
						</a>
					{/if}
				</li>
			{/each}
		</ul>

		<!-- Desktop Theme Toggle -->
		<div class="flex items-center space-x-4">
			<div class="relative flex h-10 w-10 items-center justify-center">
				<!-- Placeholder circle that's always visible -->
				<div class="h-8 w-8 rounded-full bg-[var(--fg)]/5 opacity-30"></div>

				<!-- Theme toggle with CSS animation instead of Svelte transition -->
				<div
					class="theme-button absolute inset-0 flex items-center justify-center {showThemeButton
						? 'visible'
						: ''}"
				>
					{#if $isDarkMode}
						<div class="absolute inset-0 flex items-center justify-center">
							<ButtonIcon onclick={toggleMode} icon={Moon} />
						</div>
					{:else}
						<div class="absolute inset-0 flex items-center justify-center">
							<ButtonIcon onclick={toggleMode} icon={Sun} />
						</div>
					{/if}
				</div>
			</div>
		</div>
	</div>
</nav>

<style>
	.group {
		perspective: 1000px;
	}

	.group:hover a {
		text-shadow: 0 0 10px rgba(var(--secondary-accent-rgb), 0.3);
	}

	@keyframes fadeIn {
		from {
			opacity: 0;
			transform: translateY(-10px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	li {
		animation: fadeIn 0.5s ease-out forwards;
	}

	.theme-button {
		opacity: 0;
		transform: scale(0.8);
		transition:
			opacity 0.3s ease,
			transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
	}

	.theme-button.visible {
		opacity: 1;
		transform: scale(1);
	}
</style>
