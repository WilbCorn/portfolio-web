<script lang="ts">
    import IconText from '$lib/components/home/about_me/icon-text.svelte';
    import { GraduationCap, Award, Medal, Building2, MapPin, Calendar } from '@lucide/svelte';
    import education from '$lib/data/education.json';
    import certification from '$lib/data/certification.json';

    export let bg_color = "var(--bg)";
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
            <div class="group rounded-lg bg-[{bg_color}] p-6 transition-all duration-300
                        hover:shadow-[0_0_10px_-3px_var(--fg)]">
                <div class="flex flex-col space-y-4">
                    <h3 class="text-xl font-bold text-[var(--accent)]">{edu.name}</h3>
                    
                    <div class="flex flex-wrap items-center gap-4 text-sm text-[var(--fg)]">
                        <div class="flex items-center gap-1">
                            <Building2 class="h-4 w-4" />
                            <span>{edu.location.school}</span>
                        </div>
                        <div class="flex items-center gap-1">
                            <MapPin class="h-4 w-4" />
                            <span>{edu.location.country}, {edu.location.town}</span>
                        </div>
                        <div class="flex items-center gap-1">
                            <Calendar class="h-4 w-4" />
                            <span>{edu.start} - {edu.end || 'Present'}</span>
                        </div>
                    </div>

                    {#if edu.achievements && edu.achievements.length > 0}
                        <div class="space-y-2">
                            <h4 class="font-semibold text-[var(--fg)]">Achievements</h4>
                            <ul class="list-inside space-y-1">
                                {#each edu.achievements as achievement}
                                    <li class="flex items-center gap-2 text-sm text-[var(--fg)]">
                                        <Medal class="h-4 w-4 text-[var(--gold)]" />
                                        <span>{achievement.name} ({achievement.start} - {achievement.end || 'Present'})</span>
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
    <div class="w-full border-b-2 border-[var(--fg)] pb-4 mt-8">
        <IconText
            icon={Award}
            value="Certifications"
            textClass="text-2xl font-bold text-[var(--accent)]"
            iconClass="w-6 h-6 text-[var(--accent)]"
        />
    </div>

    <div class="grid gap-4 sm:grid-cols-2 md:grid-cols-3 ">
        {#each certification as cert}
            <div class="group flex flex-col rounded-lg bg-[{bg_color} p-4
                        transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_10px_-3px_var(--fg)]">
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