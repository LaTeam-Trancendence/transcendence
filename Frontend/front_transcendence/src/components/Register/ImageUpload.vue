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
					// this.convertToBase64(file);
					// setTimeout(() => {
					// 	this.$emit('image-selected', file);
					// }, 500);
					this.$emit('image-selected', file); // Émettre un événement avec l'image
				} else {
					alert('Veuillez sélectionner un fichier image valide.');
					this.resetFile();
				}
			},

			// new
			// handleFileUpload(event) {
			// 	const file = event.target.files[0];
			// 	if (file && file.type.startsWith('image/')) {
			// 		this.previewImage = URL.createObjectURL(file);
			// 		const reader = new FileReader();
			// 		reader.onloadend = () => {
			// 			// Convertir l'image en base64
			// 			const base64Image = reader.result;
			// 			this.$emit('image-selected', base64Image);
			// 			this.selectedFile = base64Image;  // Stocker l'image en base64
			// 		};
			// 		reader.readAsDataURL(file);  // Convertir le fichier en base64
			// 	} else {
			// 		alert('Veuillez sÃ©lectionner un fichier image valide.');
			// 		this.resetFile();
			// 	}
			// },

			// Convert image to Base64 string
			// convertToBase64(file) {
			// 	const reader = new FileReader();
			// 	reader.onloadend = () => {
			// 		this.base64Image = reader.result.split(',')[1]; // Remove the 'data:image/png;base64,' prefix
			// 	};
			// 	reader.readAsDataURL(file);
			// },

			// uploadFile() {
			// 	if (!this.selectedFile) return;
		
			// 	const formData = new FormData();
			// 	formData.append('file', this.selectedFile);
		
				// Simuler un appel d'API
				// fetch('https://example.com/upload', {
				// method: 'POST',
				// body: formData,
				// })
				// .then((response) => {
				// 	if (response.ok) {
				// 	alert('Upload réussi !');
				// 	this.resetFile();
				// 	} else {
				// 	alert('Erreur lors de l’upload.');
				// 	}
				// })
				// .catch((error) => {
				// 	console.error('Erreur:', error);
				// 	alert('Erreur réseau.');
				// });
			// },
			resetFile() {
				this.selectedFile = null;
				this.previewImage = null;
			},
		},
	};
</script>
  