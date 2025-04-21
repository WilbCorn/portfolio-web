<script lang="ts">
	import '../app.css';
	import NavBar from '$lib/components/common/nav-bar.svelte';

</script>

<NavBar />

<div class="min-h-screen">
	<slot />
</div>