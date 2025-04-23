<script>
	import SectionHeading from "$lib/components/common/section-heading.svelte";
	import Tabs from "../../common/tabs.svelte";
    import Bio from "./Bio.svelte";

    // Outer variables

    export let bg_color = "var(--bg-secondary)";

    
    // Inner variables

    let items = [
        {
            value: 1,
            label: "Bio",
            component: Bio
        },
        {
            value: 2,
            label: "Skills",
            component: Bio
        },
        {
            value: 3,
            label: "Experience",
            component: Bio
        },
        {
            value: 4,
            label: "Educations/Certifications",
            component: Bio
        }
    ]


</script>

<div class="flex flex-col w-full items-start justify-center p-4" style="background-color: {bg_color}">

    <SectionHeading text="About Me"/>

    <Tabs items={items} activeTabValue={1} />

</div>