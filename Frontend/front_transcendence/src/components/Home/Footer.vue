<template>
	<footer class="bg-gray-900 text-gray-300 py-4 mt-auto">
		<div class="container mx-auto px-4">
			<div class="flex flex-wrap justify-between items-start">
				<!-- Section gauche : Equipes -->
				<div class="w-full md:w-2/3 text-center md:text-left mb-6 md:mb-0">
					<h2 class="text-xl font-semibold text-white mb-4">{{$t('Team')}}</h2>
					<div class="flex flex-col md:flex-row md:space-x-8">
						<ul class="mb-4 md:mb-0">
							<li><a href="https://github.com/Hewya" class="hover:text-white">gabarnou | Devops & Gestion</a></li>
							<li><a href="https://github.com/Maulken" class="hover:text-white">vmassoli | Data</a></li>
						</ul>
						<ul>
							<li><a href="https://github.com/guillaume7642" class="hover:text-white">gschwart | Backend</a></li>
							<li><a href="https://github.com/Banes-dev" class="hover:text-white">ehay | Frontend</a></li>
						</ul>
					</div>
				</div>
		
				<!-- Section droite : Github -->
				<div class="w-full md:w-1/3 text-center md:text-right">
					<h2 class="text-xl font-semibold text-white mb-4">{{$t('Others')}}</h2>
					<div class="flex flex-col mb-4 justify-center md:justify-end">
						<a href="https://github.com/Banes-dev/ft_transcendence" class="hover:text-white"><i class="fab fa-github mr-2"></i>{{$t('Github')}}</a>
						<router-link to="/conditions" class="hover:text-white"><i class="fa-solid fa-clipboard-list mr-2"></i> {{$t('Conditions')}}</router-link>
					</div>
				</div>
			</div>
	
			<!-- Copyright -->
			<div class="mt-8 text-center text-gray-500">
				&copy; {{new Date().getFullYear()}} Lateam
			</div>
		</div>
	</footer>
</template>
  
<script>
	export default {
		name: "Footer",
	};
</script>
  
<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
</style>
  