<script lang="ts">
	import { mount, onMount, unmount } from 'svelte';
    import Cv from './cv.svelte';
	import ButtonIcon from './common/button-icon.svelte';
	import { m } from '$lib/paraglide/messages';
	let html2pdf: any;

	function handleDownloadClick() {

		    // Create a temporary div to render the component into
			const tempDiv = document.createElement('div');
				document.body.appendChild(tempDiv);
				console.log('tempDiv', tempDiv);

			// Mount the CV component into the temp div
			const cvComponent = mount(Cv,{
				target: tempDiv,
			});

		const element = tempDiv.querySelector('#cv-content');
		if (element && html2pdf) {
			const opt = {
				margin: 0.5,
				filename: 'cv.pdf',
				image: { type: 'jpeg', quality: 98 },
				html2canvas: { scale: 2 },
				jsPDF: { unit: 'in', format: 'letter'}
			};

			html2pdf()
				.from(element)
				.set(opt)
				.save();
		}

		// Unmount the component and remove the temp div
		unmount(cvComponent);
      	document.body.removeChild(tempDiv);
	}

	onMount(async () => {
		html2pdf = (await import('html2pdf.js')).default;
	});
</script>

<div>
    <div class="pb-10">
        <ButtonIcon onclick={handleDownloadClick} buttonText={m.hero_buttons_download_cv()} />
    </div>

    <div>
        <Cv/>
    </div>

    
</div>