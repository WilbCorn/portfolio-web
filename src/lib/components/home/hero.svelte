<script>
	import { m } from '$lib/paraglide/messages.js';
	import ButtonIcon from '$lib/components/common/button-icon.svelte';
	import { GithubIcon, LinkedinIcon, Download, Send } from '@lucide/svelte';

	import { links } from '../../../config';
</script>

<div class="flex w-full items-start justify-center p-4">
	<div class="relative flex w-full max-w-7xl flex-col items-center">
		<!-- Main Row -->
		<div class="relative flex w-full flex-col items-center lg:flex-row">
			<!-- Image and SVG Blob -->
			<div class="-mt-20 ml-0 flex flex-col items-center lg:ml-10">
				<div
					class="relative mb-4 aspect-[3/4] w-[320px] sm:w-[360px] md:w-[400px] lg:w-[450px] xl:w-[500px]"
				>
					<!-- SVG Blob -->
					<div class="absolute inset-0 z-0 h-full w-full overflow-visible">
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
								d="M24,-11.3C30.4,-2.8,34.4,9.6,29.9,17.4C25.5,
                25.2,12.8,28.3,2.6,26.8C-7.6,25.4,-15.3,19.3,
              -19.6,11.6C-23.9,3.8,-24.9,-5.5,-21.1,-12.5C-17.2,
              -19.5,-8.6,-24,0.1,-24.1C8.8,-24.2,17.6,-19.7,24,-11.3Z"
								width="100%"
								height="100%"
								transform="translate(50 50)"
								stroke-width="0"
							></path>
						</svg>
					</div>

					<!-- Profile Image -->
					<img
						src="/public/static/img/profile.png"
						alt="Profile"
						class="relative z-10 h-full w-full object-cover"
						style="pointer-events: none;"
					/>
				</div>
			</div>

			<!-- Text Container -->
			<div
				class="z-10 mt-4 flex w-full flex-col items-center space-y-4 rounded-t-2xl p-6 text-center 
                       lg:mt-0 lg:ml-5 lg:items-end lg:text-right" 
			>
				<h2 class="text-xl font-bold text-[var(--secondary-accent)] sm:text-2xl">
					{m.hero_subheading()}
				</h2>
				<h1 class="text-3xl font-bold text-[var(--fg)] sm:text-4xl">{m.hero_heading()}</h1>
				<p class="max-w-xs text-base text-[var(--fg)] sm:max-w-md sm:text-lg">
					{m.hero_description()}
				</p>

				<!-- Buttons Container -->
				<div class="justify flex flex-col items-center space-y-4 lg:items-end">
					<div class="justify flex flex-row items-end space-x-2">
						<ButtonIcon
							icon={GithubIcon}
							onclick={() => window.open(links.github, '_blank')}
							buttonText=""
						/>
						<ButtonIcon
							icon={LinkedinIcon}
							onclick={() => window.open(links.linkedin, '_blank')}
							buttonText=""
						/>
					</div>
					<div class="justify flex flex-row items-end space-x-5 pt-4">
						<ButtonIcon icon={Send} onclick={() => {}} buttonText={m.hero_buttons_contact()} />
						<ButtonIcon icon={Download} onclick={() => {}} buttonText={m.hero_buttons_download_cv()} />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
