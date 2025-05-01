<script lang="ts">
	import IconText from '$lib/components/home/about_me/icon-text.svelte';
	import {
		GraduationCap,
		Award,
		Medal,
		Building2,
		MapPin,
		Calendar,
		GraduationCapIcon
	} from '@lucide/svelte';
	import education from '$lib/data/education.json';
	import certification from '$lib/data/certification.json';

	export let bg_color = 'var(--bg)';
</script>

<div class="flex w-full flex-col gap-6 p-6 bg-[{bg_color}]">
	<!-- Education Section -->
	<div class="w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={GraduationCap}
			value="Education"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<div class="grid gap-6 md:grid-cols-1">
		{#each education as edu}
			<div
				class="group rounded-lg bg-[{bg_color}] p-6 transition-all duration-300
                        hover:shadow-[0_0_10px_-3px_var(--fg)]"
			>
				<div class="flex flex-col space-y-4">
					<div class="flex flex-row justify-between">
						<h3 class="text-xl font-bold text-[var(--accent)]">{edu.name}</h3>
						<div class="flex items-center gap-1">
							<span>{edu.start.month} {edu.start.year} - {edu.end.month} {edu.end.year || 'Present'}</span>
						</div>
					</div>

                    <div class="flex flex-row gap-4">
                        <div class="flex items-center gap-1">
                            <Building2 class="h-4 w-4" />
                            <span>{edu.location.school}</span>
                        </div>
                        <div class="flex items-center gap-1">
                            <MapPin class="h-4 w-4" />
                            <span>{edu.location.country}, {edu.location.town}</span>
                        </div>
                    </div>

					<!-- CGPA Section -->
					<div class="flex flex-col gap-1.5 mt-2">
						<div class="flex items-center justify-between">
							<h4 class="text-sm font-medium text-[var(--fg-secondary)]">Current CGPA</h4>
							<!--CGPA Score -->
							<span class="flex items-baseline text-[var(--secondary-accent)]">
								<span class="text-xl font-bold">{edu.score.current_cgpa}</span>
								<span class="mx-0.5 text-xs opacity-80 font-bold"> out of </span>
								<span class="text-xs font-bold">{edu.score.limit_cgpa}</span>
							</span>
						</div>
						
						<!-- CGPA Progress Bar -->
						<div class="relative h-1 w-full rounded-full bg-[var(--surface)]/60 overflow-hidden">
							<div 
								class="absolute top-0 left-0 h-full rounded-full bg-gradient-to-r from-[var(--primary-accent)]/90 to-[var(--secondary-accent)]/90"
								style="width: {(edu.score.current_cgpa / edu.score.limit_cgpa * 100).toFixed(0)}%;"
							>
								<!-- Subtle shine effect -->
								<div class="absolute inset-0 opacity-20 animate-pulse bg-white"></div>
							</div>
						</div>
						
						 <!-- Improved distinction/merit labels -->
						{#if edu.score.current_cgpa / edu.score.limit_cgpa >= 0.85}
							<div class="flex self-end">
								<div class="rounded-sm bg-[var(--success-accent)]/10 p-2 
                                gap-1.5 border-l-2 border-[var(--success-accent)] flex flex-row 
                                items-center
                                ">
                                    <Medal class="h-3 w-3 text-[var(--gold)]" />
									<span class="text-xs font-medium text-[var(--success-accent)]">Distinction</span>
								</div>
							</div>
						{:else if edu.score.current_cgpa / edu.score.limit_cgpa >= 0.70}
							<div class="flex items-center gap-1.5 self-end">
								<div class="rounded-sm bg-[var(--secondary-accent)]/10 px-1.5 py-0.5 border-l-2 border-[var(--secondary-accent)]">
									<span class="text-xs font-medium text-[var(--secondary-accent)]">Merit</span>
								</div>
								<Medal class="h-3 w-3 text-[var(--secondary-accent)]" />
							</div>
						{/if}
					</div>

					{#if edu.achievements && edu.achievements.length > 0}
						<div class="space-y-2">
							<h4 class="font-semibold text-[var(--fg)]">Achievements</h4>
							<ul class="list-inside space-y-1">
								{#each edu.achievements as achievement}
									<li class="flex items-center gap-2 text-sm text-[var(--fg)]">
										<Medal class="h-4 w-4 text-[var(--gold)]" />
										<span
											>{achievement.name} ({achievement.start} - {achievement.end ||
												'Present'})</span
										>
									</li>
								{/each}
							</ul>
						</div>
					{/if}
				</div>
			</div>
		{/each}
	</div>

	<!-- Certifications Section -->
	<div class="mt-8 w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={Award}
			value="Certifications"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<div class="grid gap-4 sm:grid-cols-2 md:grid-cols-3">
		{#each certification as cert}
			<div
				class="group flex flex-col rounded-lg bg-[{bg_color} p-4
                        transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_10px_-3px_var(--fg)]"
			>
				<div class="flex items-start justify-between">
					<div class="flex-1">
						<h3 class="font-semibold text-[var(--accent)]">{cert.name}</h3>
						<p class="text-sm text-[var(--fg)]">{cert.provider}</p>
					</div>
					<Award class="h-5 w-5 text-[var(--accent)]" />
				</div>
				<div class="mt-2 flex items-center text-xs text-[var(--fg-secondary)]">
					<Calendar class="mr-1 h-3 w-3" />
					<span>{cert.start} {cert.end ? `- ${cert.end}` : ''}</span>
				</div>
			</div>
		{/each}
	</div>
</div>
