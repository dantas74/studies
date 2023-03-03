<template>
  <form @submit.prevent="update">
    <div class="grid grid-cols-6 gap-4">
      <div class="col-span-2">
        <label class="label-form">Beds</label>
        <input v-model.number="form.beds" class="input-form" type="text" />
        <div v-if="form.errors.beds" class="input-error">
          {{ form.errors.beds }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Baths</label>
        <input v-model.number="form.baths" class="input-form" type="text" />
        <div v-if="form.errors.baths" class="input-error">
          {{ form.errors.baths }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Area</label>
        <input v-model.number="form.area" class="input-form" type="text" />
        <div v-if="form.errors.area" class="input-error">
          {{ form.errors.area }}
        </div>
      </div>
      <div class="col-span-4">
        <label class="label-form">City</label>
        <input v-model="form.city" class="input-form" type="text" />
        <div v-if="form.errors.city" class="input-error">
          {{ form.errors.city }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Code</label>
        <input v-model="form.code" class="input-form" type="text" />
        <div v-if="form.errors.code" class="input-error">
          {{ form.errors.code }}
        </div>
      </div>
      <div class="col-span-4">
        <label class="label-form">Street</label>
        <input v-model="form.street" class="input-form" type="text" />
        <div v-if="form.errors.street" class="input-error">
          {{ form.errors.street }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Street Nr</label>
        <input v-model.number="form.street_nr" class="input-form" type="text" />
        <div v-if="form.errors.street_nr" class="input-error">
          {{ form.errors.street_nr }}
        </div>
      </div>
      <div class="col-span-6">
        <label class="label-form">Price</label>
        <input v-model.number="form.price" class="input-form" type="text" />
        <div v-if="form.errors.price" class="input-error">
          {{ form.errors.price }}
        </div>
      </div>
      <div class="col-span-6">
        <button class="btn-primary" type="submit">Create</button>
      </div>
    </div>
  </form>
</template>

<script setup>
const props = defineProps({
  listing: Object,
})

import { useForm } from '@inertiajs/vue3'

const form = useForm({
  beds: props.listing.beds,
  baths: props.listing.baths,
  area: props.listing.area,
  city: props.listing.city,
  code: props.listing.code,
  street: props.listing.street,
  street_nr: props.listing.street_nr,
  price: props.listing.price,
})

const update = () => {
  form.put(route('listing.update', [props.listing.id]))
}
</script>

<style scoped>
label {
    margin-right: 2em;
}

div {
    padding: 2px;
}
</style>
