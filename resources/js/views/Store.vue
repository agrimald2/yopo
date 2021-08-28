<template>
<div>

  <!--HEADER Y CARRITO-->

  <div class="row d-sm-block d-md-none">
    <nav class="navbar navbar-expand-md navbar-light shadow-sm fixed-top store_topbar" style="color:black;">
      <span v-if="offices[0].disabled == 1">
        YOPO MENU 
      </span>
      <span v-else>
        <a href="https://wa.me/51924649794?text=Hola,%20¿a%20que%20hora%20abriran?"><span style="color:black"> Tienda Cerrada </span> <i class="fab fa-whatsapp"  style="font-size: 1.6rem; color: black;"></i></a>
      </span>
      <router-link v-if="offices[0].disabled == 1" to="/shopping" class="d-flex align-items-center" style="color: black; font-size: 0.8rem; position:fixed; right:20vw">
        <!--<feather class="feather-lg mr-2" type="shopping-cart"/>-->
        {{ saleProducts.length }}
        <img src="@/assets/img/yellow_circle.png" alt="">
      </router-link>
      <router-link v-else to="" class="d-flex align-items-center" style="color: red; font-size: 0.8rem; position:fixed; right:20vw">
        <!--<feather class="feather-lg mr-2" type="shopping-cart"/>-->
        :(
        <img src="@/assets/img/yellow_circle.png" alt="">
      </router-link>

      <div class="category_selector row">
        <div class="category_container"> 
          <div class="" v-for="item in categories" :key="item.id">
              <a v-if="item.name==='FROZEN'" class="nav-link" href="#" @click.prevent="category_id = item.id; page = 0" style="color:#5895D3">
                <span v-if="category_id == item.id" style="color:white!important">{{ item.name }}</span>
                <span v-else>{{ item.name }}</span>
              </a>
              <a v-else class="nav-link" href="#" @click.prevent="category_id = item.id; page = 0">
                <span v-if="category_id == item.id" style="color:white!important">{{ item.name }}</span>
                <span v-else>{{ item.name }}</span>
              </a>
          </div>
        </div>
      </div>    
    </nav>


    <a href="#" @click.prevent="category_id = null; page = 0">
      <img src="@/assets/img/comeyopo.png" alt="COME YOPO" style="width: 100vw; position:fixed; bottom:0; z-index: 2;">
    </a>
  
    <div class="products_container">
      <div class="product_container row" v-for="item in filterProducts" :key="item.id">
        <product-card v-if="item.id%2 == 0" :product="item"/>
        <product-card2 v-else :product="item"/>
      </div>
    </div>
  </div>

  <div class="negro"></div>
  
  <div class="row d-none d-md-block">
    <div class="row top-store">
      <div class="row top-title">
        <div class="col-4">
            
        </div>
        <div class="col-4 center-div">
            <h4 v-if="offices[0].disabled == 1" style="font-family: EathomaSans;">
              Nuestra Carta
            </h4>
            <h4 v-else style="font-family: EathomaSans;">
              <a href="https://wa.me/51924649794?text=Hola,%20¿a%20que%20hora%20abriran?"><span style="color:black"> Tienda Cerrada </span> <i class="fab fa-whatsapp"  style="font-size: 1.6rem; color: black;"></i></a>
            </h4>
        </div>
        <div class="col-4 center-div">
          <router-link v-if="offices[0].disabled == 1" to="/shopping" class="carrito_link" style="color:white">
            <h4 style="font-family: EathomaSans;">
                {{ saleProducts.length }} <i class="fas fa-shopping-cart" style="1.2rem"></i> 
            </h4>
          </router-link>
          <img src="images/yellow_circle.png" id="yopo_logo" alt="Logo Yopo">
        </div>
      </div>
      <div class="category_selector row center-div">
        <div class="category_container col-6 center-div"> 
          <div class="" v-for="item in categories" :key="item.id">
              <a v-if="item.name==='FROZEN'" class="nav-link" href="#" @click.prevent="category_id = item.id; page = 0" style="color:#5895D3">
                <span v-if="category_id == item.id" style="color:white!important">{{ item.name }}</span>
                <span v-else>{{ item.name }}</span>
              </a>
              <a v-else class="nav-link" href="#" @click.prevent="category_id = item.id; page = 0">
                <span v-if="category_id == item.id" style="color:white!important">{{ item.name }}</span>
                <span v-else>{{ item.name }}</span>
              </a>
          </div>
        </div>
        <div class="col-6 buscador">
          <input type="search" v-model="key" class="form-control" placeholder="Buscar producto">
        </div>
      </div>
    </div>
    <div class="container row" style="padding-top:22vh;padding-bottom:5vh; justify-content:center">
      <div class="col-md-5 form-group" v-for="item in filterProducts" :key="item.id" style="margin-top:5vh">
        <product-card :product="item"/>
      </div>
    </div>
  </div>

  
  
  <div class="modal fade" id="checkModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="checkModalLabel">Mensaje</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          Agregar productos antes de proceder al carrito
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Volver</button>
        </div>
      </div>
    </div>
  </div>


</div>
</template>

<script>
import { Carousel, Slide } from 'vue-carousel';
import Categories from '@/components/Categories'
import ShoppingCard from '@/components/ShoppingCard'
import ProductCard from '@/components/ProductCard'
import ProductCard2 from '@/components/ProductCard2'
import PageNavigationStore from '@/components/PageNavigationStore'
import { mapActions, mapGetters } from 'vuex'

export default {
  components: {
    Categories,
    ShoppingCard,
    ProductCard,
    ProductCard2,
    PageNavigationStore,
    Carousel,
    Slide,
  },
  mounted() {
    var categoryId = this.$route.params.categoryId;
    this.category_id = categoryId;
    this.fetchData();
  },
  data() {
    return {
      disableds: [],
      products: [],
      categories: [],
      offices: [],
      category_id: null,
      key: null,
      page: 0,
      itemsPerPage: 18,
    }
  },
  computed: {
    ...mapGetters({
      totalProducts: 'sale/totalProducts',
      saleProducts: 'sale/products',
    }),
    computedPage: {
      get(value) {
        return this.page + 1;
      },
      set(value) {
        this.page = value - 1;
      }
    },
    pages() {
      return Math.ceil(this.products.length / this.itemsPerPage);
    },
    filterProducts() {
      return this.products.filter(e => !this.category_id || this.category_id == e.category_id)
        .filter(e => !this.key || e.name.toLowerCase().includes((this.key || '').toLowerCase()))
        .splice((this.page * this.itemsPerPage), ((this.page + 1) * this.itemsPerPage));
    }
  },
  methods: {
    ...mapActions({
      addProduct: 'sale/addProduct',
      removeProduct: 'sale/removeProduct',
      removeAllProducts: 'sale/removeAllProducts',
      minusProduct: 'sale/minusProduct',
    }),
    check() {
      if (this.saleProducts.length) {
        this.$router.push('/shopping');
      } else {
        this.$snotify.warning('Producto agregado');
      }
    },
    removeP(product) {
      this.removeProduct(product);
      axios.delete(`shoppings/${product.id}`).catch(err => {
        console.log(err.response);
      });
    },
    addP(product) {
      this.addProduct(product);
      axios.post('shoppings', { product }).catch(err => {
        console.log(err.response);
      });
    },
    plusP(product) {
      this.addProduct(product);
      axios.post('shoppings', { product }).catch(err => {
        console.log(err.response);
      });
    },
    minusP(product) {
      this.minusProduct(product);
      axios.post('shoppings', { product }).catch(err => {
        console.log(err.response);
      });
    },
    checkInventory(product) {
      var totalOne = 0;
      var totalCollectionOne = [];
      var totalTwo = 0;
      var totalCollectionTwo = [];
      
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
    fetchData() {
      axios.get('categories').then(res => {
        console.log(res);
        this.categories = res.data.categories;
      });
      axios.get('shoppings').then(res => {
        console.log(res);
        this.removeAllProducts();
        var shoppings = res.data.shoppings;
        shoppings.forEach(item => {
        var product = item.product;
          console.log(product);
          if (product) {
            product.counter = item.counter;
            console.log(product);
            this.addProduct(product);
          }
        });
      });
      axios.get('disableds/shop').then(res => {
        console.log(res);
        this.disableds = res.data.disableds;
        axios.get('products/all').then(res => {
          console.log(res);
          this.products = res.data.products.filter(item => !this.disableds.find(e => e.product_id == item.id));
        });
      });

      axios.get('offices').then(res => {
        console.log(res);
        this.offices = res.data.offices;
      });
    
    }
  }
}
</script>

<style scoped>
.center-div{
    text-align: center;
    justify-content: center;
    display: flex;
    /* justify-items: center; */
    align-items: center;
}     
.row{
  margin: 0;
}
.negro{
  position: fixed;
  background-color: black;
  top: 0;
  width: 100vw;
  height: 20vh;
}
.store_topbar{
    font-family: EathomaSans;
    background-color: #ddc237;
    height: 5vh;
    color: black;
    margin-top: 3vh;
    justify-content: center;
    text-align: center;
}
.store_topbar img{
    width: 15vw;
    right: 4vw;
    position: fixed;
    top: 2vh;
}
.category_selector{
  width: 100vw;
  height: 7vh;
  background-color: #ddc237;
  position: fixed;
  top: 13vh;
  font-family: EathomaSans;
  text-align: center;
  justify-content: center;
  display: flex;
  align-items: center;
}
.category_container{
    background-color: rgba(0, 0, 0, 0.44);
    width: 100vw;
    height: 100%;
    padding-bottom: 1.5%;
    padding-top: 1.5%; 
    overflow-x: auto;
    overflow-y: hidden;
    white-space: nowrap;
    display:flex;
}
.category_selector a{
  color: #ddc237;
}
.category_selector .col-2{
    background-color: black;
    border-radius: 5px;
    max-width: 24%;
    flex: 0 0 24%;
    margin-left: 1px;
    display: flex;
    justify-content: center;
    font-size: 0.7rem;
    color: #ddc237;
}
.products_container{
    width: 100vw;
  padding-bottom: 5vh;
    top: 22vh;
    position: absolute;
}
.product_container{
    width: 100vw;
    height: 100%;
    margin-bottom: 2vh;
}
  @media only screen and (min-width: 500px) {
    #menu{
        padding-top: 10vh;
    }
  }

  @media only screen and (min-width: 1200px) {
    .top-store{
      position:fixed;
      background-color:black;
      z-index:20;
    }
    .carrito_link{
      color:white;
    }
    .carrito:link:hover{
      color:black;
      font-size:1.5rem;
    }
    /* width */
    .category_container::-webkit-scrollbar {
      height: 10px;
      width: 5px;
    }

    /* Track */
    .category_container::-webkit-scrollbar-track {
      box-shadow: inset 0 0 5px grey;   
      border-radius: px;
    }
    
    /* Handle */
    .category_container::-webkit-scrollbar-thumb {
      background: white; 
      border-radius: 10px;
      /*border: 1px solid black;*/
    }

    /* Handle on hover */
    .category_container::-webkit-scrollbar-thumb:hover {
      background: #ddc237; 
    }
    
    #yopo_logo{ 
      position: absolute;
      top:-2.5vh;
      right:2.5vh;
      width: 10vh;
      height: 10vh;
    }
    .negro{
        display:none;
    }
    .top-store{
      /*border: 1px solid white;*/
      height: 22vh;
    }
    .top-title{
      width:100vw;
      height:5vh;
      margin-top:5vh;
      text-align:center;
      background-color: #ddc237;
    }
    .buscador{
    }
  }

  #bestseller {
    background-color: black;
    opacity: 0.6;
  }

  .container {
    max-width: 100%;
  }

  .categories {
    top: 5rem;
  }

  .btn-group button {
    background-color: black;
    color: white;
  }

  .search-input input {
    padding-right: 2rem;
    padding-left: 2rem;
    height: 4rem;
    border: none;
    font-size: 17px;
    font-weight: 100;
  }
</style>

<style scoped>
  .rectangle_store{
    width: 100vw;
    height: 5vw;
    font-size: 0.90rem;
    color: black;
  }
</style>


