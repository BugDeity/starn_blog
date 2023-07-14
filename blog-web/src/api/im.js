import request from '@/utils/request'

// 聊天室接口
export function getImHistory(params) {
    return request({
        url: '/v1/im/',
        method: 'get',
        params: params
    })
}
export function getRoomList() {
    return request({
        url: '/v1/im/getRoomList',
        method: 'get'
    })
}
export function addRoom(userId) {
    return request({
        url: '/v1/im/addRoom',
        method: 'post',
        params: {
            userId: userId
        }
    })
}
export function send(message) {
    return request({
        url: '/v1/im/chat',
        method: 'get',
        params: {
            message: message
        }
    })
}
export function getUserImHistoryList(params) {
    return request({
        url: '/v1/im/selectUserImHistory',
        method: 'get',
        params: params
    })
}
export function read(userId) {
    return request({
        url: '/v1/im/read',
        method: 'get',
        params: {
            userId: userId
        }
    })
}
export function deleteRoom(roomId) {
    return request({
        url: '/v1/im/deleteRoom',
        method: 'delete',
        params: {
            roomId: roomId
        }
    })
}
