<script lang="ts">
	import ButtonIcon from '$lib/components/common/button-icon.svelte';
	import { GithubIcon, LinkedinIcon, Download, Send } from '@lucide/svelte';
    import externalProfile from '$lib/data/external_profile.json';
	import personalInfo from '$lib/data/personal_info.json';
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';

	let path: SVGPathElement;
	let isVisible = false;
	let isSvgFinished = false;

	let my_name = personalInfo.name;

	// Increase duration to account for all animations
	const SVG_DURATION = 3000; // 2000ms draw + 1000ms fill

	onMount(() => {
		isVisible = true;
		// Wait for SVG animation to complete before showing image
		setTimeout(() => {
			isSvgFinished = true;
		}, SVG_DURATION);
	});

	function handleContactClick() {
        const subject = "Contact from Portfolio Website";
        const body = "Hello,\n\nI'd like to get in touch with you regarding...";
        
        const mailtoLink = `mailto:${personalInfo.email_address}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
        window.open(mailtoLink, '_blank');
    }

	function handleDownloadClick() {

		const pdf_name = `resume_${my_name}.pdf`;

		const resumePath = '/resume.pdf';
		
		const downloadLink = document.createElement('a');
		downloadLink.href = resumePath;
		
		downloadLink.download = pdf_name;
		
		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	}
</script>

<div class="flex w-full items-start justify-center p-4 pt-20 md:pt-10">
	<div class="relative flex w-full max-w-7xl flex-col items-center">
		<!-- Main Row -->
		<div class="relative flex w-full flex-col items-center lg:flex-row">
			<!-- Image and SVG Blob -->
			<div class="-mt-20 ml-0 flex flex-col items-center lg:ml-10">
				<div
					class="relative mb-4 aspect-[3/4] w-[320px] sm:w-[360px] md:w-[400px] lg:w-[450px] xl:w-[500px]"
				>
					<!-- SVG Blob -->
					{#if isVisible}
					<div class="absolute inset-0 z-0 h-full w-full overflow-visible"
						transition:fade={{ duration: 1000, delay: 300 }}>
						<svg
							id="sw-js-blob-svg"
							viewBox="0 0 100 100"
							xmlns="http://www.w3.org/2000/svg"
							class="h-[130%] w-[130%]"
							style="position: absolute; top: 55%; left: 45%; transform: translate(-50%, -50%); pointer-events: none;"
						>
							<defs>
								<linearGradient id="sw-gradient" x1="0" x2="1" y1="1" y2="0">
									<stop id="stop1" stop-color="var(--primary-accent)" offset="0%"></stop>
									<stop id="stop2" stop-color="var(--primary-accent)" offset="40%"></stop>
									<stop id="stop3" stop-color="var(--secondary-accent)" offset="60%"></stop>
									<stop id="stop4" stop-color="var(--secondary-accent)" offset="100%"></stop>
								</linearGradient>
							</defs>
							<path
								fill="url(#sw-gradient)"
								fill-opacity="0"
								stroke="url(#sw-gradient)"
								stroke-width="1"
								d="M24,-11.3C30.4,-2.8,34.4,9.6,29.9,17.4C25.5,25.2,12.8,28.3,2.6,26.8C-7.6,25.4,-15.3,19.3,-19.6,11.6C-23.9,3.8,-24.9,-5.5,-21.1,-12.5C-17.2,-19.5,-8.6,-24,0.1,-24.1C8.8,-24.2,17.6,-19.7,24,-11.3Z"
								transform="translate(50 50)"
								class="animate-draw"
							/>
						</svg>
					</div>

					<!-- Profile Image -->
					{#if isSvgFinished}
					<div 
						class="relative z-10 h-full w-full"
						transition:fade={{ duration: 1000 }}
					>
						<img
							src="/img/profile.png"
							alt="Profile"
							class="h-full w-full object-cover animate-fadeIn"
							style="pointer-events: none;"
						/>
					</div>
					{/if}
					{/if}
				</div>
			</div>

			<!-- Text Container -->
			<div
				class="z-10 mt-4 flex w-full flex-col items-center space-y-4 rounded-t-2xl p-6 text-center 
                       lg:mt-0 lg:ml-5 lg:items-end lg:text-right" 
			>
				<h2 class="text-xl font-bold text-[var(--secondary-accent)] sm:text-2xl">
					{personalInfo.role}
				</h2>
				<h1 class="text-3xl font-bold text-[var(--fg)] sm:text-4xl">{personalInfo.name}</h1>
				<p class="max-w-xs text-base text-[var(--fg)] sm:max-w-md sm:text-lg">
					{personalInfo.description}
				</p>

				<!-- Buttons Container -->
				<div class="justify flex flex-col items-center space-y-4 lg:items-end">
					<div class="justify flex flex-row items-end space-x-2">
						<ButtonIcon
							icon={GithubIcon}
							onclick={() => window.open(externalProfile.github.link, '_blank')}
							buttonText=""
						/>
						<ButtonIcon
							icon={LinkedinIcon}
							onclick={() => window.open(externalProfile.linked_in.link, '_blank')}
							buttonText=""
						/>
					</div>
					<div class="justify flex flex-row items-end space-x-5 pt-4">
						<ButtonIcon icon={Send} onclick={handleContactClick} buttonText={"Contact Me"} />
						<ButtonIcon icon={Download} onclick={handleDownloadClick} buttonText={"Download Resume"} />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<style>
	.animate-draw {
		animation: drawPath 2s ease forwards, 
				   fillPath 1s ease-in-out forwards 2s;
	}

	@keyframes drawPath {
		from {
			stroke-dasharray: 1000;
			stroke-dashoffset: 1000;
		}
		to {
			stroke-dashoffset: 0;
		}
	}

	@keyframes fillPath {
		from {
			fill-opacity: 0;
		}
		to {
			fill-opacity: 1;
		}
	}

	.animate-fadeIn {
		opacity: 0;
		transform: scale(0.95);
		animation: fadeIn 1s ease-out forwards;
	}

	@keyframes fadeIn {
		to {
			opacity: 1;
			transform: scale(1);
		}
	}
</style>
