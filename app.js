// Wildlife Voting System - app.js (converted)
'use strict';

class WildAnimal {
    constructor(data) {
        this.id = data.id;
        this.name = data.name;
        this.scientificName = data.scientific_name || data.scientificName || '';
        this.type = data.type || data.animal_type || 'Unknown';
        this.description = data.description || '';
        this.habitat = data.habitat || '';
        this.imageUrl = data.image_url || data.imageUrl || 'https://via.placeholder.com/400x300?text=No+Image';
        this.sound = data.sound || '';
        this.votes = data.votes || 0;
    }

    render() {
        return `
            <div class="animal-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer transform transition-all hover:shadow-2xl" 
                 onclick="app.showAnimalDetail(${this.id})" 
                 data-tooltip="คลิกเพื่อดูข้อมูลเพิ่มเติม 🐾"
                 style="animation-delay: ${Math.random() * 2}s">
                <div class="relative h-48 overflow-hidden bg-gradient-to-br from-green-400 to-emerald-600">
                    <div class="info-badge">
                        <span class="text-xs">📍 ${this.habitat.substring(0, 20)}${this.habitat.length > 20 ? '...' : ''}</span>
                    </div>

                    <img src="${this.imageUrl}" 
                         alt="${this.name}" 
                         class="w-full h-full object-cover transition-transform hover:scale-110"
                         onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'">
                    <div class="absolute top-2 right-2 bg-white rounded-full px-3 py-1 shadow vote-badge">
                        <span class="font-bold text-green-700">❤️ ${this.votes}</span>
                    </div>
                </div>
                <div class="p-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-1">${this.name}</h3>
                    <p class="text-sm text-gray-500 italic mb-2">${this.scientificName}</p>
                    <span class="inline-block bg-green-100 text-green-800 text-xs px-3 py-1 rounded-full">
                        ${this.type}
                    </span>
                    <button onclick="event.stopPropagation(); app.vote(${this.id})" 
                            class="mt-4 w-full bg-gradient-to-r from-amber-400 to-orange-500 text-white py-2 rounded-lg font-semibold hover:from-amber-500 hover:to-orange-600 transition-all transform hover:scale-105">
                        โหวต 🗳️
                    </button>
                </div>
            </div>
        `;
    }

    renderDetail() {
        return `
            <div class="relative">
                <button onclick="app.closeModal()" 
                        class="absolute top-4 right-4 bg-white rounded-full p-2 shadow-lg hover:bg-gray-100 z-10">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
                <div class="h-64 overflow-hidden bg-gradient-to-br from-green-500 to-yellow-600">
                    <img src="${this.imageUrl}" 
                         alt="${this.name}" 
                         class="w-full h-full object-cover"
                         onerror="this.src='https://via.placeholder.com/800x400?text=No+Image'">
                </div>
                <div class="p-8">
                    <div class="flex justify-between items-start mb-4">
                        <div>
                            <h2 class="text-3xl font-bold text-gray-800">${this.name}</h2>
                            <p class="text-gray-500 italic">${this.scientificName}</p>
                        </div>
                        <div class="text-right">
                            <div class="text-3xl font-bold text-red-500">❤️ ${this.votes}</div>
                            <p class="text-sm text-gray-500">คะแนนโหวต</p>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <div class="bg-green-50 p-4 rounded-lg">
                            <p class="text-sm text-gray-600 font-semibold mb-1">ประเภท:</p>
                            <p class="text-gray-800">${this.type}</p>
                        </div>

                        <div class="bg-amber-50 p-4 rounded-lg">
                            <p class="text-sm text-gray-600 font-semibold mb-1">ที่อยู่อาศัย:</p>
                            <p class="text-gray-800">${this.habitat}</p>
                        </div>

                        <div class="bg-purple-50 p-4 rounded-lg">
                            <p class="text-sm text-gray-600 font-semibold mb-1">เสียง:</p>
                            <p class="text-gray-800">${this.sound}</p>
                        </div>

                        <div class="bg-yellow-50 p-4 rounded-lg">
                            <p class="text-sm text-gray-600 font-semibold mb-1">รายละเอียด:</p>
                            <p class="text-gray-800">${this.description}</p>
                        </div>
                    </div>

                    <button onclick="app.vote(${this.id}); app.closeModal();" 
                            class="mt-6 w-full bg-gradient-to-r from-amber-400 to-orange-500 text-white py-3 rounded-lg font-bold text-lg hover:from-amber-500 hover:to-orange-600 transition-all transform hover:scale-105">
                        โหวตสัตว์นี้ 🗳️
                    </button>
                </div>
            </div>
        `;
    }

    getVotes() { return this.votes; }
}

// API Service
class APIService {
    constructor(baseURL) { this.baseURL = baseURL; }
    async get(action, params = {}) {
        try {
            const queryString = new URLSearchParams({ action, ...params }).toString();
            const response = await fetch(`${this.baseURL}?${queryString}`);
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return await response.json();
        } catch (error) { console.error('API GET Error:', error); throw error; }
    }
    async post(action, data = {}) {
        try {
            const response = await fetch(`${this.baseURL}?action=${action}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return await response.json();
        } catch (error) { console.error('API POST Error:', error); throw error; }
    }
}

class WildlifeVotingApp {
    constructor() {
        this.apiBaseURL = 'api.php';
        this.api = new APIService(this.apiBaseURL);
        this.animals = [];
        this.currentPage = 'animals';
        this.init();
    }

    async init() {
        console.log('🌿 Wildlife Voting System initialized');
        await this.loadAnimals();
        this.showPage('animals');
    }

    async loadAnimals() {
        try {
            const response = await this.api.get('getAnimals');
            if (response.success) {
                this.animals = response.data.map(data => new WildAnimal(data));
                this.renderAnimals();
                console.log(`✅ Loaded ${this.animals.length} animals`);
            } else {
                throw new Error(response.message || 'Failed to load animals');
            }
        } catch (error) {
            console.error('❌ Error loading animals:', error);
            this.showToast('เกิดข้อผิดพลาดในการโหลดข้อมูล', 'error');
            const grid = document.getElementById('animals-grid');
            grid.innerHTML = `
                <div class="col-span-full text-center text-white">
                    <p class="text-xl mb-4">⚠️ ไม่สามารถโหลดข้อมูลได้</p>
                    <button onclick="app.loadAnimals()" 
                            class="bg-white text-green-600 px-6 py-2 rounded-lg font-semibold hover:bg-gray-100">
                        ลองอีกครั้ง
                    </button>
                </div>
            `;
        }
    }

    renderAnimals() {
        const grid = document.getElementById('animals-grid');
        if (this.animals.length === 0) {
            grid.innerHTML = `
                <div class="col-span-full text-center text-white">
                    <p class="text-xl">ยังไม่มีข้อมูลสัตว์ป่า</p>
                </div>
            `;
            return;
        }
        grid.innerHTML = this.animals.map(animal => animal.render()).join('');
    }

    async showAnimalDetail(id) {
        const animal = this.animals.find(a => a.id === id);
        if (animal) {
            const modal = document.getElementById('modal');
            const modalContent = document.getElementById('modal-content');
            modalContent.innerHTML = animal.renderDetail();
            modal.classList.remove('hidden');
            modal.classList.add('flex');
            document.body.style.overflow = 'hidden';
        }
    }

    closeModal(event) {
        if (event) event.stopPropagation();
        const modal = document.getElementById('modal');
        modal.classList.add('hidden');
        modal.classList.remove('flex');
        document.body.style.overflow = 'auto';
    }

    async vote(animalId) {
        try {
            const response = await this.api.post('vote', { animal_id: animalId });
            if (response.success) {
                this.showToast('โหวตสำเร็จ! ❤️', 'success');
                await this.loadAnimals();
                if (this.currentPage === 'leaderboard') await this.loadLeaderboard();
                this.pulseVotedCard(animalId);
            } else {
                this.showToast(response.message || 'ไม่สามารถโหวตได้', 'error');
            }
        } catch (error) {
            console.error('❌ Error voting:', error);
            this.showToast('เกิดข้อผิดพลาดในการโหวต', 'error');
        }
    }

    pulseVotedCard(animalId) {
        const cards = document.querySelectorAll('.animal-card');
        cards.forEach(card => {
            if (card.getAttribute('onclick') && card.getAttribute('onclick').includes(animalId.toString())) {
                card.classList.add('pulse-vote');
                setTimeout(() => card.classList.remove('pulse-vote'), 1000);
            }
        });
    }

// (leaderboard/stats functions continue below — omitted for brevity in file)
