<script>
	import SectionHeading from "$lib/components/common/section-heading.svelte";
	import Tabs from "../../../common/tabs.svelte";
    import Bio from "../bio.svelte";
	import Experiences from "./experiences.svelte";
	import Qualifications from "./qualifications.svelte";
	import Skills from "./skills.svelte";

    // Outer variables

    export let bg_color = "var(--bg-secondary)";

    
    // Inner variables

    let items = [
    // {
    //     label: "Bio",
    //     component: Bio
    // },
    {
        label: "Skills",
        component: Skills
    },
    {
        label: "Experiences",
        component: Experiences
    },
    {
        label: "Qualifications",
        component: Qualifications
    }
    ];


    let tabs = items.map((item, index) => ({
    ...item,
    value: index + 1
}));


</script>

<div class="flex flex-col w-full items-start justify-center p-4" style="background-color: {bg_color}">

    <SectionHeading text="About Me"/>

    <Tabs items={tabs} activeTabValue={1} />

</div>