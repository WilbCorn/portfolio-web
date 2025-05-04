<script lang="ts">
	import { Calendar, Award, Link2, Brain, Wrench, X, LockOpen, Image as ImageIcon } from '@lucide/svelte';
	import { fade, fly, scale, slide } from 'svelte/transition';
	import { quintOut, backOut } from 'svelte/easing';
	import { onMount } from 'svelte';
    import personalInfo from '$lib/data/personal_info.json';

	export let project: {
		name: string;
		description: string;
		achievements: string[];
		year: string;
		duration: string;
		link: string;
		soft_skills_utilized: string[];
		hard_skills_utilized: string[];
		images?: string[];
	};
	export let onClose: () => void;

	let selectedImageIndex = 0;
	let mainImageKey = 0;
	let modalElement: HTMLDivElement;

	onMount(() => {
		modalElement?.focus();
		document.body.style.overflow = 'hidden'; // Prevent background scrolling
		return () => {
			document.body.style.overflow = ''; // Restore scrolling on unmount
		};
	});

	function handleEscape(event: KeyboardEvent) {
		if (event.key === 'Escape') {
			onClose();
		}
	}

	function handleModalClick(event: MouseEvent) {
		if (event.target === event.currentTarget) {
			onClose();
		}
	}

	function selectImage(index: number) {
		if (selectedImageIndex !== index) {
			selectedImageIndex = index;
			mainImageKey++;
		}
	}

    function handleContactClick(project_name : String) {
        const subject = `Contact from Portfolio Website Regarding "${project_name}" Project`;
		const body = `Hello,\n\nI'd like to get in touch with you regarding your project called "${project_name}"`;
        
        const mailtoLink = `mailto:${personalInfo.email_address}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
        window.open(mailtoLink, '_blank');
    }

</script>

<!-- Modal Backdrop -->
<div
	class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 p-2 backdrop-blur-md sm:p-4"
	transition:fade={{ duration: 250 }}
	on:click={handleModalClick}
	on:keydown={handleEscape}
	role="dialog"
	aria-modal="true"
	aria-labelledby="modal-title"
	tabindex="-1"
	bind:this={modalElement}
>
	<!-- Modal Content Container -->
	<div
		class="max-h-[95vh] w-full max-w-3xl overflow-y-auto rounded-xl border border-[var(--fg)]/10 bg-[var(--bg-secondary)] shadow-2xl sm:max-h-[90vh]"
		transition:fly={{ y: 30, duration: 400, easing: backOut }}
		role="document"
	>
		<!-- Header -->
		<div
			class="sticky top-0 z-10 flex items-start justify-between border-b border-[var(--fg)]/10 bg-[var(--bg-secondary)]/90 p-4 backdrop-blur-sm sm:p-6"
		>
			<div>
				<h2
					id="modal-title"
					class="text-xl font-bold text-[var(--accent)] sm:text-2xl"
					in:slide={{ delay: 100, duration: 300 }}
				>
					{project.name}
				</h2>
				<div
					class="mt-2 flex items-center text-xs text-[var(--fg-secondary)] sm:text-sm"
					in:fade={{ delay: 200, duration: 300 }}
				>
					<Calendar class="mr-1 h-3.5 w-3.5 sm:h-4 sm:w-4" />
					<span>{project.year} {project.duration ? `• ${project.duration}` : ''}</span>
				</div>
			</div>
			<button
				class="rounded-full p-1.5 transition-all duration-200 hover:scale-110 hover:bg-[var(--fg)]/10 active:scale-95 sm:p-2"
				on:click={onClose}
				aria-label="Close dialog"
			>
				<X class="h-4 w-4 sm:h-5 sm:w-5" />
			</button>
		</div>

		<!-- Content Body -->
		<div class="space-y-6 p-4 sm:space-y-8 sm:p-6">
			<!-- Image Gallery -->
			{#if project.images && project.images.length > 0}
				<div class="space-y-3 sm:space-y-4" in:fly={{ y: 20, duration: 400, delay: 150 }}>
					<h3
						class="flex items-center gap-2 text-base font-semibold text-[var(--accent)] sm:text-lg"
					>
						<ImageIcon class="h-4 w-4 sm:h-5 sm:w-5" />
						Gallery
					</h3>
					<!-- Main Image Display -->
					<div
						class="group relative aspect-video w-full overflow-hidden rounded-lg bg-[var(--bg)] shadow-inner"
					>
						{#key mainImageKey}
							<img
								src={project.images[selectedImageIndex]}
								alt="{project.name} - Image {selectedImageIndex + 1}"
								class="absolute inset-0 h-full w-full object-contain transition-all duration-700 ease-out group-hover:scale-[1.02]"
								in:fade={{ duration: 400 }}
							/>
						{/key}
					</div>

					<!-- Thumbnails -->
					{#if project.images.length > 1}
						<div class="flex space-x-1.5 overflow-x-auto pb-2 sm:space-x-2">
							{#each project.images as image, index}
								<button
									on:click={() => selectImage(index)}
									class="relative h-12 w-12 flex-shrink-0 overflow-hidden rounded-md border-2 transition-all duration-300 sm:h-16 sm:w-16
                                           {selectedImageIndex === index
										? 'scale-105 border-[var(--accent)] shadow-md'
										: 'border-transparent hover:border-[var(--fg)]/50'}"
									aria-label="Select image {index + 1}"
									in:scale={{
										duration: 300,
										delay: 250 + index * 70,
										start: 0.8,
										easing: quintOut
									}}
								>
									<img src={image} alt="Thumbnail {index + 1}" class="h-full w-full object-cover" />
									{#if selectedImageIndex !== index}
										<div
											class="absolute inset-0 bg-black/40 transition-opacity duration-300 hover:opacity-0"
										></div>
									{/if}
								</button>
							{/each}
						</div>
					{/if}
				</div>
			{/if}

			<!-- Description -->
			<div class="space-y-3 sm:space-y-4" in:fly={{ y: 20, duration: 400, delay: 200 }}>
				<p class="text-sm leading-relaxed text-[var(--fg)] sm:text-base">{project.description}</p>
			</div>

			<!-- Achievements -->
			{#if project.achievements.length > 0}
				<div class="space-y-3 sm:space-y-4" in:fly={{ y: 20, duration: 400, delay: 250 }}>
					<h3
						class="flex items-center gap-2 text-base font-semibold text-[var(--accent)] sm:text-lg"
					>
						<Award class="h-4 w-4 sm:h-5 sm:w-5" />
						Achievements
					</h3>
					<ul
						class="list-inside list-disc space-y-1.5 text-sm text-[var(--fg)] sm:space-y-2 sm:text-base"
					>
						{#each project.achievements as achievement, i}
							<li
								class="transition-all duration-300 hover:translate-x-1"
								in:fly={{ x: -10, y: 0, duration: 300, delay: 300 + i * 100 }}
							>
								{achievement}
							</li>
						{/each}
					</ul>
				</div>
			{/if}

			<!-- Skills -->
			<div
				class="grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-6"
				in:fly={{ y: 20, duration: 400, delay: 300 }}
			>
				<!-- Hard Skills -->
				{#if project.hard_skills_utilized.length > 0}
					<div class="space-y-3 sm:space-y-4">
						<h3
							class="flex items-center gap-2 text-base font-semibold text-[var(--primary-accent)] sm:text-lg"
						>
							<Wrench class="h-4 w-4 sm:h-5 sm:w-5" />
							Technical Skills
						</h3>
						<div class="flex flex-wrap gap-1.5 sm:gap-2">
							{#each project.hard_skills_utilized as skill, i}
								<span
									class="rounded-full bg-[var(--primary-accent)]/10 px-2 py-0.5 text-xs font-medium
                                       text-[var(--primary-accent)] transition-all duration-300 hover:scale-105 hover:bg-[var(--primary-accent)]/20 hover:shadow-sm
                                       sm:px-3 sm:py-1 sm:text-sm"
									in:scale={{ duration: 300, delay: 350 + i * 70, start: 0.8, easing: quintOut }}
								>
									{skill}
								</span>
							{/each}
						</div>
					</div>
				{/if}

				<!-- Soft Skills -->
				{#if project.soft_skills_utilized.length > 0}
					<div class="space-y-3 sm:space-y-4">
						<h3
							class="flex items-center gap-2 text-base font-semibold text-[var(--secondary-accent)] sm:text-lg"
						>
							<Brain class="h-4 w-4 sm:h-5 sm:w-5" />
							Soft Skills
						</h3>
						<div class="flex flex-wrap gap-1.5 sm:gap-2">
							{#each project.soft_skills_utilized as skill, i}
								<span
									class="rounded-full bg-[var(--secondary-accent)]/10 px-2 py-0.5 text-xs font-medium
                                       text-[var(--secondary-accent)] transition-all duration-300 hover:scale-105 hover:bg-[var(--secondary-accent)]/20 hover:shadow-sm
                                       sm:px-3 sm:py-1 sm:text-sm"
									in:scale={{ duration: 300, delay: 400 + i * 70, start: 0.8, easing: quintOut }}
								>
									{skill}
								</span>
							{/each}
						</div>
					</div>
				{/if}
			</div>

			<!-- Project Link -->
			{#if project.link}
				<div class="pt-2 sm:pt-4" in:scale={{ duration: 300, delay: 450, start: 0.9 }}>
					<a
						href={project.link}
						target="_blank"
						rel="noopener noreferrer"
						class="inline-flex transform items-center gap-2 rounded-lg bg-[var(--secondary-accent)] px-3 py-1.5
                  text-sm font-medium text-[var(--bg)] shadow-md transition-all
                  duration-300 hover:-translate-y-1 hover:bg-[var(--primary-accent)] hover:shadow-lg active:translate-y-0
                  active:shadow-md sm:px-4 sm:py-2 sm:text-base"
					>
						<Link2 class="h-3.5 w-3.5 sm:h-4 sm:w-4" />
						View Project
					</a>
				</div>
			{:else}
				<div class="pt-2 sm:pt-4" in:scale={{ duration: 300, delay: 450, start: 0.9 }}>
					<button
						type="button"
						on:click={() => handleContactClick(project.name)}
						on:keydown={(e) => { if (e.key === 'Enter' || e.key === ' ') { handleContactClick(project.name); } }}
						class="inline-flex transform items-center gap-2 rounded-lg bg-[var(--secondary-accent)] px-3 py-1.5
				  text-sm font-medium text-[var(--bg)] shadow-md transition-all
				  duration-300 hover:-translate-y-1 hover:bg-[var(--primary-accent)] hover:shadow-lg active:translate-y-0
				  active:shadow-md sm:px-4 sm:py-2 sm:text-base"
						aria-label="Request Access"
					>
						<LockOpen class="h-3.5 w-3.5 sm:h-4 sm:w-4" />
						Request Access
					</button>
				</div>
			{/if}
		</div>
	</div>
</div>

<svelte:window on:keydown={handleEscape} />

<style>
	/* Add smooth scrolling for thumbnail container on touch devices */
	.overflow-x-auto {
		-webkit-overflow-scrolling: touch;
		scrollbar-width: none; /* Firefox */
		-ms-overflow-style: none; /* IE and Edge */
	}

	/* Hide scrollbar for thumbnail container */
	.overflow-x-auto::-webkit-scrollbar {
		display: none; /* Safari and Chrome */
	}

	/* Animated underline effect for headings */
	h3 {
		position: relative;
	}

	h3::after {
		content: '';
		position: absolute;
		left: 0;
		bottom: -4px;
		width: 0;
		height: 2px;
		background-color: currentColor;
		opacity: 0.6;
		transition: width 0.3s ease-out;
	}

	h3:hover::after {
		width: 100%;
	}

	/* Optimize animations for users who prefer reduced motion */
	@media (prefers-reduced-motion: reduce) {
		* {
			animation-duration: 0.01ms !important;
			transition-duration: 0.01ms !important;
		}
	}
</style>
