<script>
	import IconText from '$lib/components/home/about_me/icon-text.svelte';

	import { Computer, ThumbsUp, CheckCircle2, Speech, Languages, Award } from '@lucide/svelte';

	import techSkills from '$lib/data/tech_skills.json';
	import softSkills from '$lib/data/soft_skills.json';
	import languages from '$lib/data/languages.json';

	let thumbsUpCategory = ["Intermediate", "Advanced"];
</script>

<div class="flex w-full flex-col gap-6 p-6">
	<!-- Header Section -->
	<div class="w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={Computer}
			value="Technical Skills"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<!-- Skills Grid -->
	<div class="grid w-full grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-4">
		{#each techSkills as category}
			<div
				class="group flex flex-col rounded-lg bg-[var(--bg-secondary)] p-6
        shadow-none
        transition-shadow
        duration-300 hover:shadow-[0_0_10px_-3px_var(--fg)]"
			>
				<div class="flex flex-col mb-4 border-b border-[var(--fg)] pb-2 justify-center items-center">
					<h2 class="text-xl font-semibold text-[var(--accent)]">
						{category.category}
					</h2>
				</div>

				<!-- Skills List -->
				<ul class="grid grid-cols-1 gap-2">
					{#each category.skills as skill}
						<li class="flex items-center text-[var(--fg)]">
							<div class="w-5 mr-2 flex items-center justify-center">
								{#if thumbsUpCategory.includes(skill.proficiency)}
									<ThumbsUp class="w-4 h-4 text-[var(--success-accent)]" />
								{/if}
							</div>
							<span class="mr-2 h-2 w-2 rounded-full bg-[var(--accent)]"></span>
							<span class="text-sm font-medium">{skill.name}</span>
						</li>
					{/each}
				</ul>
			</div>
		{/each}
	</div>

	<!-- Soft Skills Section -->
	<div class="w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={Speech}
			value="Soft Skills"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<div class="grid w-full grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4 mt-4">
		{#each softSkills as skill}
			<div class="flex items-center p-3 rounded-lg bg-[var(--bg-secondary)] 
						transition-all duration-300 hover:scale-105 group">
				<CheckCircle2 class="w-4 h-4 mr-2 text-[var(--success-accent)] 
									transition-transform duration-300 group-hover:rotate-12" />
				<span class="text-sm font-medium text-[var(--fg)]">{skill}</span>
			</div>
		{/each}
	</div>

	<!-- Language Skills Section -->
	<div class="w-full border-b-2 border-[var(--fg)] pb-4">
		<IconText
			icon={Languages}
			value="Language Skills"
			textClass="text-2xl font-bold text-[var(--accent)]"
			iconClass="w-6 h-6 text-[var(--accent)]"
		/>
	</div>

	<div class="grid w-full grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 mt-4">
		{#each languages as language}
			<div class="flex flex-col p-4 rounded-lg bg-[var(--bg-secondary)] 
						transition-all duration-300 hover:scale-[1.02] group hover:shadow-[0_0_10px_-3px_var(--fg)]">
				<div class="flex items-center mb-2">
					<span class="text-lg font-semibold text-[var(--accent)] pr-5">{language.name}</span>
					{#if language.expertise === "Native"}
						<ThumbsUp class="w-4 h-4 text-[var(--success-accent)]" />
					{/if}
				</div>
				
				<span class="text-sm text-[var(--fg)]">{language.expertise}</span>
				
				{#if language.certification && language.certification.length > 0}
					<div class="mt-2 flex items-center text-xs text-[var(--fg-secondary)]">
						<Award class="w-3 h-3 mr-1 text-[var(--gold)]" />
						{#each language.certification as cert}
							<span>{cert.name}: {cert.score}</span>
						{/each}
					</div>
				{/if}
			</div>
		{/each}
	</div>
</div>
