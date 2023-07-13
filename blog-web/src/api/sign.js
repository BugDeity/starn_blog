import request from '@/utils/request'

export function getSignRecords(params) {
    return request({
        url: '/v1/sign/getSignRecords',
        method: 'get',
        params: params
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