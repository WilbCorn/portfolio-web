<script lang="ts">
    import SectionHeading from "$lib/components/common/section-heading.svelte";
	import SeparatorWavy from "$lib/components/common/separator-wavy.svelte";
	import Careers from "./careers.svelte";
    import Experiences from "./experiences.svelte";
    import Qualifications from "./qualifications.svelte";
    import Skills from "./skills.svelte";

    export let bg_color = "var(--bg-secondary)";
    
    // Custom action for scroll animations
    function inView(node: HTMLElement, params = { threshold: 0.2, rootMargin: "0px", once: false }) {
        let observer: IntersectionObserver;
        
        const handleIntersect = (entries: IntersectionObserverEntry[]) => {
            const entry = entries[0];
            if (entry.isIntersecting) {
                node.dispatchEvent(new CustomEvent('inview'));
                node.style.opacity = "1";
                node.style.transform = "translateY(0)";
                // Optionally unobserve after animation
                if (params.once) observer.unobserve(node);
            } else if (!params.once) {
                // Only reset if not "once" mode
                node.style.opacity = "0";
                node.style.transform = "translateY(30px)";
            }
        };
        
        const init = () => {
            // Setup initial styles
            node.style.opacity = "0";
            node.style.transform = "translateY(30px)";
            node.style.transition = `opacity 0.8s ease, transform 0.8s ease`;
            
            observer = new IntersectionObserver(handleIntersect, {
                threshold: params.threshold,
                rootMargin: params.rootMargin
            });
            
            observer.observe(node);
        };
        
        init();
        
        type InViewParams = { threshold: number; rootMargin: string; once: boolean };
        
        return {
            update(newParams: Partial<InViewParams>) {
                params = { ...params, ...newParams };
                if (observer) observer.disconnect();
                init();
            },
            destroy() {
                if (observer) observer.disconnect();
            }
        };
    }
</script>

<div id="about" class="flex flex-col w-full items-start justify-center" style="background-color: {bg_color}">
    <!-- Header uses different animation -->
    <div class="w-full" use:inView={{ threshold: 0.1, rootMargin: "-10px", once: false }}>
        <SectionHeading text="About Me"/>
    </div>

    <!-- Skills Section -->
    <div id="about-skills" class="w-full my-8" use:inView={{ threshold: 0.1, rootMargin: "-30px", once: false  }}>
        <Skills />
    </div>

    
    <!-- Experience Section -->
    <div id="about-experiences" class="w-full" use:inView={{ threshold: 0.1, rootMargin: "-30px", once: false  }}>
        <SeparatorWavy color="var(--bg)" />
        <Experiences bg_color="var(--bg)"/>
        <SeparatorWavy color="var(--bg)" flipped={true} />
    </div>

    <!-- Careers Section -->
    <div id="about-careers" class="w-full" use:inView={{ threshold: 0.1, rootMargin: "-30px", once: false }}>
        <Careers bg_color="var(--bg-secondary)"/>
    </div>

    <!-- Qualifications Section -->
    <div id="about-qualifications" class="w-full" use:inView={{ threshold: 0.1, rootMargin: "-30px", once: false }}>
        <SeparatorWavy color="var(--bg)" flipped={false} />
        <Qualifications bg_color="var(--bg)"/>
    </div>
</div>

<style>
    @media (prefers-reduced-motion: reduce) {
        :global(*) {
            animation-duration: 0.01ms !important;
            transition-duration: 0.01ms !important;
        }
    }
</style>