<template>
     <div>
        <v-dialog show-overlay
      persistent
      width="300px"
      :value="retornar">
     <v-card
        color="light-blue darken-4"
        dark
      >
        <v-card-text>
          Espere porfavor...
          <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
          ></v-progress-linear>
        </v-card-text>
      </v-card>
        </v-dialog>
     </div>
</template>
<script>
export default {
    data(){
        return {
        overlay:false,
        }
    },
    computed:{
         retornar(){                
            this.overlay = this.activo;
            return  this.overlay;
         },
         
    },
    props:{
        activo:null,
    },
    methods:{
        enviarResult(){
            this.$emit('escucharResultPantalla',false);
        }
    }
}
</script>