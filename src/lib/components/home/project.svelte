<script lang="ts">
    import { CodeXml } from '@lucide/svelte';
    import IconText from "$lib/components/home/about_me/icon-text.svelte";
    import ProjectCard from './projects/project-card.svelte';
    import projects from '$lib/data/projects.json';
    import { fade, fly } from 'svelte/transition';
    import { onMount } from 'svelte';

    let isVisible = false;

    export let bg_color = "var(--bg)";

    onMount(() => {
        isVisible = true;
    });
</script>

<section class="flex w-full flex-col gap-8 p-6 pb-30 bg-[{bg_color}]">
    <div class="w-full border-b-2 border-[var(--fg)] pb-4">
        <IconText
            icon={CodeXml}
            value="Projects"
            textClass="text-2xl font-bold text-[var(--accent)]"
            iconClass="w-6 h-6 text-[var(--accent)]"
        />
    </div>

    {#if isVisible}
        <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {#each projects.filter(p => p.name !== "") as project, i}
                <div
                    in:fly={{ y: 20, duration: 300, delay: i * 100 }}
                    out:fade
                >
                    <ProjectCard {project} />
                </div>
            {/each}
        </div>
    {/if}
</section>