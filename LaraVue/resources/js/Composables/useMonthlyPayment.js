import { computed, isRef } from 'vue'

export const useMonthlyPayment = (totalValue, interestRate, duration) => {
  const monthlyPayment = computed(() => {
    const price = (isRef(totalValue) ? totalValue.value : totalValue)
    const monthlyInterest = (isRef(interestRate) ? interestRate.value : interestRate) / 100 / 12
    const numberOfPaymentMonths = (isRef(duration) ? duration.value : duration) * 12

    return price * monthlyInterest * (Math.pow(1 + monthlyInterest, numberOfPaymentMonths)) / (Math.pow(1 + monthlyInterest, numberOfPaymentMonths) - 1)
  })

  const totalPaid = computed(() => {
    return (isRef(duration) ? duration.value : duration) * 12 * monthlyPayment.value
  })

  const totalInterest = computed(() => totalPaid.value - (isRef(totalValue) ? totalValue.value : totalValue))

  return { monthlyPayment, totalPaid, totalInterest }
}
