<template>
<div class="modal fade" id="shoppingModal" role="dialog">
  <div class="modal-dialog">
    <form @submit.prevent="submit" class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">#COME YOPO</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="email">Por favor, ingresa tus datos para continuar</label>
          <select class="custom-select op-white" v-model="delivery" required>
            <option :value="null" disabled="disabled" selected="selected" class="op-white">DISTRITO DE ENTREGA</option>
            <option v-for="item in deliveries" :value="item" :key="item.id" class="op-white">{{ `${item.name} - Costo: S/ ${item.price.toFixed(2)}` }}</option>
          </select>
        </div>
        <div class="form-group">
          <input type="tel" v-model="customer.document" class="form-control" placeholder="DNI" minlength="8" maxlength="8" @input="findCustomer" required>
        </div>
        <div class="form-group">
          <input type="text" v-model="customer.name" class="form-control" placeholder="Nombre Completo" required>
        </div>
        <div class="form-group">
          <input type="tel" v-model="customer.mobile" class="form-control" placeholder="Numero de celular" minlength="9" maxlength="9" required>
        </div>
        <div class="form-group">
          <input type="email" v-model="customer.email" class="form-control" placeholder="Email" required>
        </div>
        <div class="form-group">
          <input type="text" v-model="customer.address" class="form-control" placeholder="Direccion de entrega" required>
        </div>
        <div class="form-group">
          <input type="text" v-model="customer.reference" class="form-control" placeholder="Referencia de la direccion" required>
        </div>
        <!--div class="form-group">
          <input type="text" v-model="observations" class="form-control" placeholder="Alguna observación">
        </div-->
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-dark" style="color:white">
          Confirmar
        </button>
      </div>
    </form>
  </div>
</div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  mounted() {
    this.fecthData();
  },
  data() {
    return {
      delivery: null,
      deliveries: [],
      customer: {},
    }
  },
  // nuevo
  computed: {
    ...mapGetters({
      sale: 'sale/getSale',
      products: 'sale/products',
      totalProducts: 'sale/totalProducts',
    }),
  },
  // nuevo
  methods: {
    ...mapActions({
      removeAllProducts: 'sale/removeAllProducts',
      removeProduct: 'sale/removeProduct',
    }),
    fecthData() {
      axios.get('deliveries').then(res => {
        //console.log(res);
        this.deliveries = res.data.deliveries;
      });
    },
    findCustomer() {
      if (this.customer.document.length == 8) {
        var params = {
          dni: this.customer.document,
        };
        axios.get('customers/byDni', { params }).then(res => {
          console.log(res);
          this.customer = res.data.customer;
        }).catch(err => {
          console.log(err.response);
        });
      }
    },
    
    submit() {
      // nuevo
      let inventories = [];
      this.products.forEach(item => {
        inventories.push(...this.checkInventory(item));
      });
      // nuevo

      for (var i = inventories.length - 1; i >= 0; i--) {
        console.log(inventories[i]['codigo']);
      }

      /*$('.modal').modal('hide');
      this.$loading(true);*/
      axios.post('customers', { 
        customer: this.customer,
        customerid: this.customer.id,
        
        deliveryid: this.delivery.id,
        deliveryprice: this.delivery.price,
        
        invent: inventories,
      
      }).then(res => {
        
        console.log(res.config.data);
        //console.log(res.data.saleid);
        //console.log(res);
        
        var customer = res.data.customer;
        var sale = {};
        sale.customer_id = customer.id,
        sale.delivery_id = this.delivery.id;
        sale.delivery_price = this.delivery.price;
        sale.email = customer.email;
        //$('.modal').modal('hide');
        // this.$loading(false);
        //this.$emit('confirm', sale);
        axios.get('shoppings/removeAll').catch(err => {
          console.log(err.response);
        });
        this.removeAllProducts();
        //this.$router.push({name:"store"}) // nuevo
        window.location.href = "https://api.whatsapp.com/send/?phone="+"51934094501"+"&text=Hola%2C+este+es+mi+pedido%3A%0Ayopo.test%2F"+res.data.saleid+"%2FcheckoutDetails%0AQuedo+a+la+espera+de+su+confirmaci%C3%B3n&app_absent=0";
        
      }).catch(err => {
        console.log(err.response);
      });
    }
    
   
  }
}
</script>

<style scoped>
  select{
      border: 1px solid black;
    background-color: black;
  }
  ::placeholder{
    color: #fff;
  }

  input{
  border: 1px solid black;
  background-color: black;
  }
  select{
    border: 1px solid black;
  }
  .modal-header{
    background-color: black;
    color: #ddc237;
    font-family: 'EATHOMASANS';
  }
  .modal-footer{
        background-color: black;
    font-family: 'EATHOMASANS';
  }
  .modal-body{
    background-color: #ddc237;
  }
  button{
    background-color: #ddc237;
    color: black!important;
  }
  .op-white{
    color: white;
  }
</style>