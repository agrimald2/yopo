require('./bootstrap');
import Vue from 'vue'
import App from './App.vue'
import StoreApp from './StoreApp'
import router from './router'
import store from './store'
import VueFeather from 'vue-feather'
import Snotify from 'vue-snotify'
import PageNavigation from '@/components/PageNavigation'
import Datepicker from '@/components/Datepicker'
import ToggleButton from '@/components/ToggleButton'
import VueLoading from 'vuejs-loading-plugin'
import VueMoment from 'vue-moment'
import moment from 'moment-timezone'
import VueCarousel from 'vue-carousel';


const VueScrollTo = require('vue-scrollto')
Vue.use(VueScrollTo)

Vue.component(VueFeather.name, VueFeather);
Vue.component('page-navigation', PageNavigation);
Vue.component('datepicker', Datepicker);
Vue.component('toggle-button', ToggleButton);

Vue.use(VueLoading);
Vue.use(Snotify, { toast: { timeout: 4000 } });
Vue.use(VueMoment, {moment})
Vue.use(VueCarousel);


Vue.mixin({
    data() {
        return {
            unitCodes: [
                { unitCode: 'NIU', name: 'UNIDADES' },
                { unitCode: 'KGM', name: 'KILOGRAMOS' },
                { unitCode: 'BG', name: 'BOLSAS' },
                { unitCode: 'BO', name: 'BOTELLAS' },
                { unitCode: 'BX', name: 'CAJAS' },
                { unitCode: 'PK', name: 'PAQUETES' },
            ],
        }
    },
    methods: {
        checkInventory(product) {
            var totalOne = 0;
            var totalCollectionOne = [];
            var totalTwo = 0;
            var totalCollectionTwo = [];

            if (product.picked.length) {
                return product.picked;
            }

            for (const inventory of product.inventory) {
                if (product.counter % inventory.weight) {
                    continue;
                }
                if (product.counter >= (totalOne + inventory.weight)) {
                    totalOne += inventory.weight;
                    totalCollectionOne.push(inventory);
                }
            }

            for (const inventory of product.inventory) {
                if (product.counter >= (totalTwo + inventory.weight)) {
                    totalTwo += inventory.weight;
                    totalCollectionTwo.push(inventory);
                }
            }

            var minOne = product.counter - totalOne;
            var minTwo = product.counter - totalTwo;

            if (minOne < minTwo) {
                if (!totalCollectionOne.length && product.inventory.length) {
                    totalCollectionOne.push(product.inventory.slice(-1)[0]);
                    return totalCollectionOne;
                } else {
                    return totalCollectionOne;
                }
            } else {
                if (!totalCollectionTwo.length && product.inventory.length) {
                    totalCollectionTwo.push(product.inventory.slice(-1)[0]);
                    return totalCollectionTwo;
                } else {
                    return totalCollectionTwo;
                }
            }
        },
        formatCode(code) {
            var string = '' + code;
            switch (string.length) {
                case 1:
                    return `00000${code}`;
                case 2:
                    return `0000${code}`;
                case 3:
                    return `000${code}`;
                case 4:
                    return `00${code}`;
                case 5:
                    return `0${code}`;
                case 6:
                    return `${code}`;
            }
        },
        formatTime(date) {
            date = new Date(date);
            var ampm = 'AM';
            var hours = date.getHours();
            var minutes = date.getMinutes();
            if (hours >= 12) {
                ampm = 'PM';
            }
            if (hours >= 13) {
                hours -= 12;
            }
            // Formatear 2 dijitos
            if (hours < 10) {
                hours = `0${hours}`;
            }
            if (minutes < 10) {
                minutes = `0${minutes}`;
            }
            return `${hours} : ${minutes} ${ampm}`;
        },
        formatDate(date) {
            moment.locale('es');
            var d = moment(date);
            return d.tz('America/Lima').format('ll')
        },
    }
});

new Vue({
    router,
    store,
    render: function(h) {
        if (this.$route.path.includes('/store') || this.$route.path == '/payment' || this.$route.path == '/shopping' || this.$route.path.includes('/checkout')) {
            return h(StoreApp);
        } else {
            return h(App);
        }
    },
}).$mount('#app');