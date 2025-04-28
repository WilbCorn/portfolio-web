<script lang="ts">
    import { Phone, Mail, MapPin, Github, Linkedin } from '@lucide/svelte';
    import { links } from '../../config';
    import personalInfo from '$lib/data/personal_info.json';
</script>

<footer class="w-full bg-[var(--bg-secondary)] py-8 mt-auto">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between items-center gap-8">
            <!-- Contact Info -->
            <div class="flex flex-col gap-4">
                <h3 class="text-xl font-bold text-[var(--accent)]">Contact Me</h3>
                <div class="flex flex-col gap-2">
                    <a href={`tel:${personalInfo.telp_no}`} 
                       class="flex items-center gap-2 text-[var(--fg)] hover:text-[var(--accent)] transition-colors">
                        <Phone class="h-4 w-4" />
                        <span>{personalInfo.telp_no}</span>
                    </a>
                    <a href={`mailto:${personalInfo.email_address}`}
                       class="flex items-center gap-2 text-[var(--fg)] hover:text-[var(--accent)] transition-colors">
                        <Mail class="h-4 w-4" />
                        <span>{personalInfo.email_address}</span>
                    </a>
                    <div class="flex items-center gap-2 text-[var(--fg)]">
                        <MapPin class="h-4 w-4" />
                        <span>{personalInfo.location.country}, {personalInfo.location.address.city}</span>
                    </div>
                </div>
            </div>

            <!-- Social Links -->
            <div class="flex gap-4">
                <a href={links.github} target="_blank" rel="noopener noreferrer"
                   class="p-2 rounded-full bg-[var(--bg)] text-[var(--fg)] 
                          hover:text-[var(--accent)] transition-colors">
                    <Github class="h-6 w-6" />
                </a>
                <a href={links.linkedin} target="_blank" rel="noopener noreferrer"
                   class="p-2 rounded-full bg-[var(--bg)] text-[var(--fg)]
                          hover:text-[var(--accent)] transition-colors">
                    <Linkedin class="h-6 w-6" />
                </a>
            </div>
        </div>

        <!-- Copyright -->
        <div class="mt-8 text-center text-sm text-[var(--fg-secondary)]">
            <p>© {new Date().getFullYear()} {personalInfo.name}. All rights reserved.</p>
        </div>
    </div>
</footer>