<script lang="ts">
    import IconText from '$lib/components/home/about_me/icon-text.svelte';
    import { Briefcase, Calendar, Building2, Crown } from '@lucide/svelte';
    import experiences from '$lib/data/experiences.json';

    // Add function to check for achievement keywords
    function isAchievementRole(role: string): boolean {
        const achievementKeywords = ['champion', 'winner', 'first place', '1st', 'gold'];
        return achievementKeywords.some(keyword => 
            role.toLowerCase().includes(keyword.toLowerCase())
        );
    }
</script>

<div class="flex w-full flex-col gap-6 p-6">
    <!-- Header Section -->
    <div class="w-full border-b-2 border-[var(--fg)] pb-4">
        <IconText
            icon={Briefcase}
            value="Experience"
            textClass="text-2xl font-bold text-[var(--accent)]"
            iconClass="w-6 h-6 text-[var(--accent)]"
        />
    </div>

    <!-- Timeline -->
    <div class="relative flex flex-col space-y-8 pl-4">
        {#each experiences.filter(exp => exp.name !== "") as experience}
            <div class="group relative flex items-start">
                <!-- Timeline line -->
                <div class="absolute h-50 ml-0.25 w-0.5 bg-[var(--fg)] group-last:h-20"></div>
                
                <!-- Timeline dot -->
                <div class="absolute -left-1.5 h-4 w-4 rounded-full bg-[var(--bg-secondary)] 
                ring-4 ring-[var(--primary-accent)] transition-all duration-300 
                group-hover:scale-150 group-hover:ring-[var(--secondary-accent)]"></div>

                <!-- Content -->
                <div class="ml-8 flex flex-col space-y-3 pb-8">
                    <div class="flex flex-col space-y-1">
                        <h3 class="text-xl font-bold text-[var(--accent)]">
                            {experience.name}
                        </h3>
                        <div class="flex items-center space-x-2 text-sm text-[var(--fg)]">
                            {#if isAchievementRole(experience.role)}
                            <Crown class="h-4 w-4 text-[var(--gold)] animate-pulse" />
                            {/if}
                            <span class="font-semibold">{experience.role}</span>
                            {#if experience.organization}
                                <span>•</span>
                                <div class="flex items-center">
                                    <Building2 class="mr-1 h-4 w-4" />
                                    <span>{experience.organization}</span>
                                </div>
                            {/if}
                        </div>
                        <div class="flex items-center text-sm text-[var(--fg-secondary)]">
                            <Calendar class="mr-1 h-4 w-4" />
                            <span>{experience.year}</span>
                            {#if experience.duration}
                                <span class="mx-1">•</span>
                                <span>{experience.duration}</span>
                            {/if}
                        </div>
                    </div>

                    {#if experience.contribution.length > 0 && experience.contribution[0] !== ""}
                        <ul class="list-disc list-inside space-y-1 text-sm text-[var(--fg)]">
                            {#each experience.contribution as point}
                                <li>{point}</li>
                            {/each}
                        </ul>
                    {/if}

                    {#if experience.soft_skills_utilized.length > 0 || experience.hard_skills_utilized.length > 0}
                        <div class="flex flex-wrap gap-2">
                            {#each [...experience.soft_skills_utilized, ...experience.hard_skills_utilized] as skill}
                                <span class="rounded-full bg-[var(--bg-secondary)] px-3 py-1 
                                           text-xs font-medium text-[var(--accent)]">
                                    {skill}
                                </span>
                            {/each}
                        </div>
                    {/if}
                </div>
            </div>
        {/each}
    </div>
</div>