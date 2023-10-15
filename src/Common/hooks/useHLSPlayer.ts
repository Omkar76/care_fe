import ReactPlayer from "react-player";
import { IOptions } from "./useMSEplayer";

export const useHLSPLayer = (ref: any) => {
  const startStream = ({ onSuccess, onError }: IOptions = {}) => {
    const videoEle = ref.player.player.player;

    try {
      const player = ref as ReactPlayer;

      videoEle.addEventListener("playing", onSuccess);
      videoEle.addEventListener("error", onError);

      player.seekTo(player.getDuration());
    } catch (err) {
      onError && onError(err);
    } finally {
      // eslint-disable-next-line no-unsafe-finally
      return () => {
        videoEle.removeEventListener("playing", onSuccess);
        videoEle.removeEventListener("error", onError);
      };
    }
  };
  return {
    startStream,
    stopStream: undefined,
  };
};
