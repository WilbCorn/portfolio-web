<script lang="ts">
    import IconText from '$lib/components/home/about_me/icon-text.svelte';
    import { Briefcase, Calendar, Building2, Crown, Brain, Wrench, ExternalLink, Github } from '@lucide/svelte'; // Added ExternalLink, Github
    import experiences from '$lib/data/experiences.json';

    // Add function to check for achievement keywords
    function isAchievementRole(role: string): boolean {
        const achievementKeywords = ['champion', 'winner', 'first place', '1st', 'gold'];
        return achievementKeywords.some(keyword =>
            role.toLowerCase().includes(keyword.toLowerCase())
        );
    }

    // Helper to get appropriate icon based on link label/URL
    function getLinkIcon(link: { url: string; name: string }) {
        if (link.url.includes('github.com')) {
            return Github;
        }
        return ExternalLink; // Default icon
    }

    export const bg_color = "var(--bg)";
</script>

<div class="flex w-full flex-col gap-6 p-6 bg-[{bg_color}]">
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
    <div class="relative flex flex-col pl-4">
        {#each experiences.filter(exp => exp.name !== "") as experience, i}
            <!-- Timeline item -->
            <div class="group relative flex items-start pb-12">

                <!-- Timeline line -->
                {#if i < experiences.filter(exp => exp.name !== "").length -1}
                    <div class="absolute left-4 top-4 bottom-0 w-0.5 -translate-x-1/2 bg-gradient-to-b from-[var(--primary-accent)]/70 to-[var(--fg)]/20"></div>
                {/if}

                <!-- Timeline dot -->
                <div class="absolute left-4 top-2 z-10 h-4 w-4 -translate-x-1/2 rounded-full bg-[var(--bg-secondary)]
                           ring-4 ring-[var(--primary-accent)] transition-all duration-300
                           group-hover:scale-110 group-hover:ring-[var(--secondary-accent)]"></div>

                <!-- Content -->
                <div class="ml-10 flex flex-col space-y-4 w-full">
                    <!-- Header info -->
                    <div class="flex flex-col space-y-2">
                        <h3 class="text-xl font-bold text-[var(--accent)] transition-colors duration-300 group-hover:text-[var(--secondary-accent)]">
                            {experience.name}
                        </h3>
                        <div class="flex flex-wrap items-center gap-x-2 text-sm text-[var(--fg)]">
                            {#if isAchievementRole(experience.role)}
                                <Crown class="h-4 w-4 text-yellow-500" />
                            {/if}
                            <span class="font-semibold">{experience.role}</span>
                            {#if experience.organization}
                                <span class="hidden sm:inline">•</span>
                                <div class="flex items-center basis-full sm:basis-auto">
                                    <Building2 class="mr-1 h-4 w-4 flex-shrink-0" />
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

                    <!-- Contributions -->
                    {#if experience.contribution.length > 0 && experience.contribution[0] !== ""}
                        <div class="bg-[var(--bg-secondary)]/50 rounded-lg p-3 border border-[var(--fg)]/10">
                            <ul class="list-disc list-inside space-y-1.5 text-sm text-[var(--fg)]">
                                {#each experience.contribution as point}
                                    <li class="transition-transform duration-200 hover:translate-x-1">{point}</li>
                                {/each}
                            </ul>
                        </div>
                    {/if}

                    <!-- Skills Sections -->
                    {#if experience.soft_skills_utilized.length > 0 || experience.hard_skills_utilized.length > 0}
                        <div class="grid sm:grid-cols-2 gap-4 pt-1">
                            <!-- Hard Skills -->
                            {#if experience.hard_skills_utilized.length > 0}
                                <div class="space-y-2">
                                    <div class="flex items-center gap-2">
                                        <Wrench class="h-4 w-4 text-[var(--primary-accent)]" />
                                        <span class="text-sm font-medium text-[var(--primary-accent)]">Technical Skills</span>
                                    </div>
                                    <div class="flex flex-wrap gap-2">
                                        {#each experience.hard_skills_utilized as skill}
                                            <span class="rounded-full bg-[var(--primary-accent)]/10 px-3 py-1 
                                                       text-xs font-medium text-[var(--accent)] transition-all duration-200 
                                                       hover:bg-[var(--primary-accent)]/20 hover:scale-105 hover:shadow-sm">
                                                {skill}
                                            </span>
                                        {/each}
                                    </div>
                                </div>
                            {/if}

                            <!-- Soft Skills -->
                            {#if experience.soft_skills_utilized.length > 0}
                                <div class="space-y-2">
                                    <div class="flex items-center gap-2">
                                        <Brain class="h-4 w-4 text-[var(--secondary-accent)]" />
                                        <span class="text-sm font-medium text-[var(--secondary-accent)]">Soft Skills</span>
                                    </div>
                                    <div class="flex flex-wrap gap-2">
                                        {#each experience.soft_skills_utilized as skill}
                                            <span class="rounded-full bg-[var(--secondary-accent)]/10 px-3 py-1 
                                                       text-xs font-medium text-[var(--secondary-accent)] transition-all duration-200 
                                                       hover:bg-[var(--secondary-accent)]/20 hover:scale-105 hover:shadow-sm">
                                                {skill}
                                            </span>
                                        {/each}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    {/if}

                    <!-- Links Section -->
                    {#if experience.links && experience.links.length > 0}
                        <div class="flex flex-wrap gap-2 pt-2">
                            {#each experience.links as link}
                                <a href={link.url}
                                   target="_blank"
                                   rel="noopener noreferrer"
                                   class="inline-flex items-center gap-1.5 px-3 py-1 rounded-lg
                                          border border-[var(--fg)]/20 text-[var(--fg)] text-xs font-medium
                                          hover:bg-[var(--fg)]/10 hover:border-[var(--fg)]/40 transition-colors shadow-sm hover:shadow-md">
                                    <svelte:component this={getLinkIcon(link)} class="w-3.5 h-3.5 flex-shrink-0" />
                                    <span>{link.name}</span>
                                </a>
                            {/each}
                        </div>
                    {/if}
                </div>
            </div>
        {/each}
    </div>
</div>