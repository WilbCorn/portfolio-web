<script lang="ts">
	import {
		Briefcase,
		MapPin,
		Calendar,
		Award,
		Building2,
		ExternalLink,
		Code,
		Brain
	} from '@lucide/svelte';
	import IconText from '$lib/components/home/about_me/icon-text.svelte';
	import careers from '$lib/data/careers.json';

	export let bg_color = 'var(--bg)';

	type Period = {
		start: {
			month: string;
			year: number;
		};
		end: {
			month?: string;
			year?: number;
		};
	};

	function formatPeriod(period: Period) {
		const { start, end } = period;
		const startText = `${start.month} ${start.year}`;
		const endText = end.month && end.year ? `${end.month} ${end.year}` : 'Present';
		return `${startText} - ${endText}`;
	}
</script>

<div class="flex w-full flex-col gap-6 p-6 bg-[{bg_color}]">
	<!-- Header Section -->
	<div class="w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={Briefcase}
			value="Career Journey"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<!-- Career Timeline -->
	<div class="relative flex flex-col pl-4">
		{#each careers as career, i}
			<!-- Timeline item -->
			<div class="group relative flex items-start pb-16 last:pb-6">
				<!-- Timeline line -->
				{#if i < careers.length - 1}
					<div
						class="absolute top-4 bottom-0 left-4 w-0.5 -translate-x-1/2 bg-gradient-to-b from-[var(--primary-accent)]/90 to-[var(--primary-accent)]/20"
					></div>
				{/if}

				<!-- Timeline dot -->
				<div
					class="absolute top-2 left-4 z-10 h-4 w-4 -translate-x-1/2 rounded-full bg-[var(--bg-secondary)]
                           ring-4 ring-[var(--primary-accent)] transition-all duration-300
                           group-hover:scale-110 group-hover:ring-[var(--secondary-accent)]"
				></div>

				<!-- Content -->
				<div class="ml-10 flex w-full flex-col space-y-4">
					<!-- Header info -->
					<div class="flex flex-col space-y-3">
						<!-- Company and Position -->
						<div>
							<h3
								class="flex items-center text-xl font-bold text-[var(--accent)] transition-colors duration-300 group-hover:text-[var(--secondary-accent)]"
							>
								{career.position}
								{#if career.highlight}
									<span
										class="ml-2 rounded-full bg-yellow-500/20 px-2 py-0.5 text-xs text-yellow-500"
										>Featured</span
									>
								{/if}
							</h3>

							<div class="mt-1 flex items-center space-x-1">
								<Building2 class="h-4 w-4 text-[var(--fg-secondary)]" />
								<a
									href={career.company_url}
									target="_blank"
									rel="noopener noreferrer"
									class="flex items-center font-medium text-[var(--fg)] transition-colors hover:text-[var(--accent)]"
								>
									{career.company}
									<ExternalLink class="ml-1 inline h-3 w-3" />
								</a>
							</div>
						</div>

						<!-- Location and Duration -->
						<div class="flex flex-wrap items-center gap-3 text-sm text-[var(--fg-secondary)]">
							<div class="flex items-center">
								<MapPin class="mr-1 h-4 w-4" />
								<span>{career.location.city}, {career.location.country}</span>
							</div>

							<div class="flex items-center">
								<Calendar class="mr-1 h-4 w-4" />
								<span>
									{career.periods.map((p) => formatPeriod(p as Period)).join(' | ')}
								</span>
							</div>

							<!-- <span
								class="rounded-full bg-[var(--primary-accent)]/10 px-2 py-0.5 text-xs font-medium text-[var(--primary-accent)]"
							>
								{career.type}
							</span> -->
						</div>
					</div>

					<!-- Description -->
					{#if career.description}
						<p class="text-sm leading-relaxed text-[var(--fg)]">{career.description}</p>
					{/if}

					<!-- Responsibilities -->
					{#if career.responsibilities && career.responsibilities.length > 0}
						<div class="rounded-lg border border-[var(--fg)]/10 bg-[var(--bg-secondary)]/50 p-4">
							<h4 class="mb-2 text-sm font-medium text-[var(--accent)]">Key Responsibilities</h4>
							<ul class="list-inside list-disc space-y-1.5 text-sm text-[var(--fg)]">
								{#each career.responsibilities as responsibility}
									<li class="transition-transform duration-200 hover:translate-x-1">
										{responsibility}
									</li>
								{/each}
							</ul>
						</div>
					{/if}

					<!-- Skills Sections -->
					{#if (career.technologies && career.technologies.length > 0) || (career.soft_skills && career.soft_skills.length > 0)}
						<div class="grid gap-4 sm:grid-cols-2">
							<!-- Technical Skills -->
							{#if career.technologies && career.technologies.length > 0}
								<div class="space-y-2">
									<div class="flex items-center gap-2">
										<Code class="h-4 w-4 text-[var(--primary-accent)]" />
										<span class="text-sm font-medium text-[var(--primary-accent)]"
											>Technologies</span
										>
									</div>
									<div class="flex flex-wrap gap-1.5">
										{#each career.technologies as tech}
											<span
												class="rounded-full bg-[var(--primary-accent)]/10 px-2 py-0.5
                                                       text-xs font-medium text-[var(--primary-accent)] transition-all duration-200
                                                       hover:scale-105 hover:bg-[var(--primary-accent)]/20"
											>
												{tech}
											</span>
										{/each}
									</div>
								</div>
							{/if}

							<!-- Soft Skills -->
							{#if career.soft_skills && career.soft_skills.length > 0}
								<div class="space-y-2">
									<div class="flex items-center gap-2">
										<Brain class="h-4 w-4 text-[var(--secondary-accent)]" />
										<span class="text-sm font-medium text-[var(--secondary-accent)]"
											>Soft Skills</span
										>
									</div>
									<div class="flex flex-wrap gap-1.5">
										{#each career.soft_skills as skill}
											<span
												class="rounded-full bg-[var(--secondary-accent)]/10 px-2 py-0.5
                                                       text-xs font-medium text-[var(--secondary-accent)] transition-all duration-200
                                                       hover:scale-105 hover:bg-[var(--secondary-accent)]/20"
											>
												{skill}
											</span>
										{/each}
									</div>
								</div>
							{/if}
						</div>
					{/if}

					<!-- Achievements -->
					{#if career.achievements && career.achievements.length > 0}
						<div class="space-y-2">
							<div class="flex items-center gap-2">
								<Award class="h-4 w-4 text-yellow-500" />
								<span class="text-sm font-medium text-[var(--accent)]">Achievements</span>
							</div>
							<ul class="space-y-1">
								{#each career.achievements as achievement}
									<li
										class="relative pl-6 text-sm before:absolute before:top-[0.5em] before:left-0 before:h-1.5 before:w-1.5 before:rounded-full before:bg-yellow-500/70"
									>
										{achievement}
									</li>
								{/each}
							</ul>
						</div>
					{/if}

					<!-- Company Logo -->
					{#if career.company_logo}
					<div
						class="absolute top-2 right-2 h-12 w-12 items-center justify-center 
							rounded-lg bg-white/90 p-1.5 shadow-sm backdrop-blur-md 
							transition-all duration-500 ease-in-out hidden sm:flex
							sm:h-16 sm:w-16 sm:p-2 sm:opacity-70 sm:scale-95 sm:bg-white/80
							sm:group-hover:opacity-100 sm:group-hover:scale-100 sm:group-hover:shadow-lg 
							sm:group-hover:bg-white/95"
						>
						<img
							src={career.company_logo}
							alt="{career.company} logo"
							class="h-full w-full object-contain object-center
								transform transition-all duration-500 
								sm:filter sm:grayscale-[30%] sm:group-hover:grayscale-0 sm:group-hover:brightness-110
								dark:invert-[0.15] sm:group-hover:dark:invert-0"
						/>
						</div>
					{/if}
				</div>
			</div>
		{/each}
	</div>
</div>
