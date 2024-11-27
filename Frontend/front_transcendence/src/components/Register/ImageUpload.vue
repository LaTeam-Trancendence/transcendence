<template>
    <div class="flex flex-col items-center space-y-4 p-6 bg-gray-700 rounded-lg shadow-md">
		<label
			for="file-input"
			class="cursor-pointer flex flex-col items-center justify-center w-full h-40 border-2 border-dashed border-yellow-300 rounded-lg bg-gray-600 hover:bg-gray-500"
		>
			<div class="text-center">
			<p class="text-gray-300 text-sm">Cliquez ou glissez une image ici</p>
			<p class="text-xs text-gray-400">(JPG, PNG, max 5MB)</p>
			</div>
			<input
			id="file-input"
			type="file"
			accept="image/*"
			class="hidden"
			@change="handleFileUpload"
			/>
		</label>
	
		<div v-if="previewImage" class="w-40 h-40 overflow-hidden rounded-lg">
			<img :src="previewImage" alt="Prévisualisation" class="object-cover w-full h-full" />
		</div>
	
		<!-- <button
			v-if="selectedFile"
			class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600"
			@click="uploadFile"
		>Upload
		</button> -->
    </div>
</template>
  
<script>
	export default {
		data() {
		return {
			selectedFile: null,
			previewImage: null,
		};
		},
		methods: {
		handleFileUpload(event) {
			const file = event.target.files[0];
			if (file && file.type.startsWith('image/')) {
			this.selectedFile = file;
			this.previewImage = URL.createObjectURL(file);
			} else {
			alert('Veuillez sélectionner un fichier image valide.');
			this.resetFile();
			}
		},
		uploadFile() {
			if (!this.selectedFile) return;
	
			const formData = new FormData();
			formData.append('file', this.selectedFile);
	
			// Simuler un appel d'API
			fetch('https://example.com/upload', {
			method: 'POST',
			body: formData,
			})
			.then((response) => {
				if (response.ok) {
				alert('Upload réussi !');
				this.resetFile();
				} else {
				alert('Erreur lors de l’upload.');
				}
			})
			.catch((error) => {
				console.error('Erreur:', error);
				alert('Erreur réseau.');
			});
		},
		resetFile() {
			this.selectedFile = null;
			this.previewImage = null;
		},
		},
	};
</script>
  
<style scoped>
	/* Ajout d'un hover pour les zones actives (optionnel) */
</style>
  