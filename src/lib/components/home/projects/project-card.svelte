<script lang="ts">
    import { Calendar, Award, CornerRightUp } from '@lucide/svelte';
    import ProjectDetails from './project-details.svelte';

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

    export let bg_color = "var(--bg)";

    let showDetails = false;

    function handleInteraction() {
        showDetails = true;
    }

    function handleKeydown(event: KeyboardEvent) {
        if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            handleInteraction();
        }
    }
</script>

<div class="group relative overflow-hidden rounded-xl bg-[{bg_color}] p-6 
            cursor-pointer transition-all duration-300 hover:-translate-y-1 
            hover:shadow-[0_0_10px_-3px_var(--fg)]"
     on:click={handleInteraction}
     on:keydown={handleKeydown}
     role="button"
     tabindex="0"
     aria-label="View details of {project.name}">
    <!-- Corner Peek Effect -->
    <div class="absolute -right-12 -top-12 h-24 w-24 rotate-45 
                transition-all duration-300 bg-[var(--primary-accent)] opacity-0 
                group-hover:opacity-100">
    </div>
    <CornerRightUp class="absolute right-3 top-3 h-5 w-5 text-[var(--bg)] 
                  transition-all duration-700 opacity-0 group-hover:opacity-100
                  group-hover:rotate-[-90deg]" />

    <!-- Preview Content -->
    <div class="flex flex-col space-y-4 transition-all duration-300">
        <h3 class="text-xl font-bold text-[var(--accent)] transition-colors duration-300">
            <span class="group-hover:text-[var(--primary-accent)]">{project.name}</span>
        </h3>
        
        <p class="text-sm text-[var(--fg)] line-clamp-2">
            {project.description}
        </p>
        
        <div class="flex items-center space-x-4 text-xs text-[var(--fg-secondary)]">
            <div class="flex items-center">
                <Calendar class="mr-1 h-4 w-4" />
                <span>{project.year} {project.duration ? `• ${project.duration}` : ''}</span>
            </div>
            {#if project.achievements.length > 0}
                <div class="flex items-center">
                    <Award class="mr-1 h-4 w-4 text-yellow-400" />
                    <span>{project.achievements.length} achievements</span>
                </div>
            {/if}
        </div>

        <!-- Skills Tags -->
        <div class="flex flex-wrap gap-2">
            {#each project.hard_skills_utilized.slice(0, 3) as skill}
                <span class="rounded-full bg-[var(--primary-accent)] bg-opacity-10 px-3 py-1 
                           text-xs font-medium text-white">
                    {skill}
                </span>
            {/each}
            {#if project.hard_skills_utilized.length > 3}
                <span class="rounded-full bg-[var(--secondary-accent)] bg-opacity px-3 py-1 
                           text-xs font-medium text-[var(--bg)]">+{project.hard_skills_utilized.length - 3} more</span>
            {/if}
        </div>
    </div>

    <!-- Animated Indicators -->
    <div class="absolute bottom-4 right-4 flex items-center space-x-1.5">
        {#each Array(3) as _, i}
            <div class="h-2 w-2 rounded-full bg-[var(--primary-accent)] 
                       opacity-0 transform translate-y-2
                       group-hover:opacity-100 group-hover:translate-y-0
                       transition-all duration-300"
                 style="transition-delay: {i * 100}ms">
            </div>
        {/each}
    </div>
</div>

{#if showDetails}
    <ProjectDetails {project} onClose={() => showDetails = false} />
{/if}
