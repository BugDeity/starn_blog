import request from '@/utils/request'

export function addSponsor(payImage) {
    return request({
        url: '/v1/sponsor/add',
        method: 'get',
        params: {
            payImage: payImage
        }
    })
}
export function validateTodayIsSign() {
    return request({
        url: '/v1/sign/validateTodayIsSign',
        method: 'get',
    })
}
export function sign(time) {
    return request({
        url: '/v1/sign/',
        method: 'get',
        params: {
            time: time
        }
    })
}